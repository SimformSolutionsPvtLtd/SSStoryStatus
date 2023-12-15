//
//  Enums.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

// MARK: - StoryDirection
/// The type for story change direction.
public enum StoryDirection {
    /// Previous direction.
    case previous
    
    // Next direction.
    case next
}

// MARK: - Image Caching Type
// The type of image cache.
public enum ImageCacheType {
    
    /// In-memory cache using `NSCache`.
    case nscache
    
    /// On-disk caching using file system.
    case ondisk
}

// MARK: - ImageType
/// The type of image.
public enum ImageType {
    
    /// Story type optionally containing date of creation.
    case story(Date? = nil)
    
    // Profile type for profile images.
    case profile
    
    /// Any other images.
    case other
}
