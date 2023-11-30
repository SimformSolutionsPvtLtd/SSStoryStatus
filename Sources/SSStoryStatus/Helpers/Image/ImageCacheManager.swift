//
//  ImageCacheManager.swift
//  
//
//  Created by Krunal Patel on 31/10/23.
//

import UIKit

class ImageCacheManager {

    // MARK: - Cache instance
    private let imageCache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    // MARK: - Methods
    func addImage(image: UIImage, url: URL) {
        imageCache.setObject(image, forKey: url as NSURL)
    }
    
    func getImage(for url: URL) -> UIImage? {
        return imageCache.object(forKey: url as NSURL)
    }
    
    func removeImage(for url: URL) {
        return imageCache.removeObject(forKey: url as NSURL)
    }
    
    func clearCache() {
        imageCache.removeAllObjects()
    }
    
    // MARK: - Shared instance
    static let shared = ImageCacheManager()
    
    // MARK: - Initializer
    private init() { }
}
