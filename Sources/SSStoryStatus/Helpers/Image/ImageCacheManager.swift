//
//  ImageCacheManager.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 31/10/23.
//

import UIKit

class ImageCacheManager {
    
    // MARK: - Cache Instance
    private var imageCache: any ImageCache
    
    // MARK: - Methods
    func addImage(image: UIImage, url: URL, type: ImageType) {
        imageCache.set(image, url: url, type: type)
    }
    
    func getImage(for url: URL, type: ImageType) -> UIImage? {
        return imageCache.get(for: url, type: type)
    }
    
    func removeImage(for url: URL, type: ImageType) {
        return imageCache.remove(for: url, type: type)
    }
    
    func clearCache(olderThan date: Date) {
        (imageCache as? StorageImageCache)?.clearCache(olderThan: date)
    }
    
    func changeCache<T: ImageCache>(_ cache: T) {
        self.imageCache = cache
    }
    
    // MARK: - Shared Instance
    static var shared: ImageCacheManager = ImageCacheManager()
    
    // MARK: - Initializer
    private init(cache: any ImageCache = .storage) {
        self.imageCache = cache
    }
}
