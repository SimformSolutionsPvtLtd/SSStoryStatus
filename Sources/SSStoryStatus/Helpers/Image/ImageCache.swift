//
//  ImageCache.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 07/11/23.
//

import UIKit

// MARK: - ImageCache Protocol
/// A type used to manage caching of UIImage.
///
/// You can create custom implementation by confirming to `ImageCache` protocol. And providing implementations for required methods.
///
/// ```swift
/// struct MyImageCache: ImageCache {
///     let cache = MyCache() // Cache storage
///
///     func get(for url: URL, type: ImageType) -> UIImage? {
///         cache.get(url)
///     }
///
///     func set(_ image: UIImage, url: URL, type: ImageType) {
///         cache.set(image, key: url)
///     }
///
///     func remove(for url: URL, type: ImageType) {
///         cache.remove(url)
///     }
///
///     func clearAll() {
///         cache.clearAll()
///     }
/// }
/// ```
///
/// By default two implementations are are provided.
///
/// - ``NSImageCache`` - Uses `NSCache` for temporary caching.
/// - ``StorageImageCache`` - Uses `file storage` for caching.
public protocol ImageCache {
    
    associatedtype CacheType
    
    static var shared: CacheType { get }
    
    func get(for url: URL, type: ImageType) -> UIImage?
    
    func set(_ image: UIImage, url: URL, type: ImageType)
    
    func remove(for url: URL, type: ImageType)
    
    func clearAll()
}

// MARK: - NSImageCache
/// Implementing temporary caching by using `NSCache`.
///
/// Cache will be automatically deleted when the application is terminated.
public class NSImageCache: ImageCache {
    
    // MARK: - Cache Instance
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    // MARK: - Methods
    public func set(_ image: UIImage, url: URL, type: ImageType) {
        cache.setObject(image, forKey: url as NSURL)
    }
    
    public func get(for url: URL, type: ImageType) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    public func remove(for url: URL, type: ImageType) {
        return cache.removeObject(forKey: url as NSURL)
    }
    
    public func clearAll() {
        cache.removeAllObjects()
    }
    
    // MARK: - Shared Instance
    public static var shared: NSImageCache = NSImageCache()
    
    // MARK: - Private Initializer
    private init() { }
}

// MARK: - ImageCache+NSImageCache Instance
extension ImageCache where Self == NSImageCache {
    
    public static var nscache: NSImageCache { .shared }
}

// MARK: - StorageImageCache
/// Implementing `File Storage` for image caching.
///
/// Cached data will be stored into file storage and will be awailable untill cleared.
///
/// Images are stored in `jpeg` format with `compressionQuality: 0.8`.
///
/// Cache can be cleared by pasing date object to `cacheExpire` parameter
/// in ``SSStoryStatus/SSStoryStatus/init(users:sorted:cacheExpire:)``.
///
/// Default cache clearing time is 24 hours old.
///
/// ```swift
/// struct ContentView: View {
///
///     let expireDate = Calendar.current.date(byAdding: .day, value: -1, to: .now) // 1 day ago
///
///     var body: some View {
///         SSStoryStatus(users: users, cacheExpire)
///     }
/// }
/// ```
///
/// > Note: Profile images can't be cleared by `cacheExpire`.
public class StorageImageCache: ImageCache {
    
    // MARK: - Vars & Lets
    private let fileManager = FileManager.default
    
    private lazy var cacheDirectoryURL = {
        let url = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: Paths.cacheDirectoryName)
            .appending(path: Paths.imageCacheDirectoryName)
        return url
    }()
    
    // MARK: - Public Methods
    public func get(for url: URL, type: ImageType) -> UIImage? {
        let fileURL = getFileUrl(for: url.md5String, type: type)
        
        return UIImage(contentsOfFile: fileURL.path())
    }
    
    public func set(_ image: UIImage, url: URL, type: ImageType) { 
        createFolderIfNeeded(type: type)
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let fileURL = getFileUrl(for: url.md5String, type: type)
        try? data.write(to: fileURL)
        
        if case .story(let date) = type, let date {
            setCreationDate(for: fileURL.path(), date: date)
        }
    }
    
    public func remove(for url: URL, type: ImageType) {
        let fileURL = getFileUrl(for: url.path(), type: type)
        
        try? fileManager.removeItem(at: fileURL)
    }
    
    public func clearCache(olderThan date: Date) {
        fileManager.clearCache(directory: cacheDirectory(for: .story()), olderThan: date)
    }
    
    public func clearAll() {
        try? fileManager.removeItem(at: cacheDirectoryURL)
    }
    
    // MARK: - Private Methods
    private func cacheDirectory(for type: ImageType) -> URL {
        var url = cacheDirectoryURL
        
        switch type {
        case .profile:
            url.append(path: Paths.profileCacheDirectoryName)
        case .story(_):
            url.append(path: Paths.storyCacheDirectoryName)
        default:
            break
        }
        
        return url
    }
    
    private func getFileUrl(for fileName: String, type: ImageType = .other, fileExtension: String = "jpeg") -> URL {
        createFolderIfNeeded()
        return cacheDirectory(for: type).appending(path: fileName).appendingPathExtension(fileExtension)
    }
    
    private func createFolderIfNeeded(type: ImageType = .other) {
        guard !fileManager.fileExists(atPath: cacheDirectory(for: type).path()) else { return }
        
        try? fileManager.createDirectory(at: cacheDirectory(for: type), withIntermediateDirectories: true)
    }
    
    private func setCreationDate(for path: String, date: Date) {
        try? fileManager.setAttributes([.creationDate: date], ofItemAtPath: path)
    }
    
    // MARK: - Shared Instance
    public static var shared: StorageImageCache = StorageImageCache()
    
    // MARK: - Private Initializer
    private init() { }
}

// MARK: - ImageCache+StorageImageCache Instance
extension ImageCache where Self == StorageImageCache {
    
    public static var storage: StorageImageCache { .shared }
}
