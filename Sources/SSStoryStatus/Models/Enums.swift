//
//  Enums.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

// MARK: - StoryDirection
public enum StoryDirection {
    case previous
    case next
}

// MARK: - ImageSize
public enum ImageSize {
    case small
    case large
    case fullscape
}

// MARK: - Image Caching Type
public enum ImageCacheType {
    case nscache
    case ondisk
}

// MARK: - ImageType
public enum ImageType {
    case story(Date? = nil)
    case profile
    case other
}
