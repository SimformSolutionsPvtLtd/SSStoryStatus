//
//  SSStoryStatus.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

/// Create customizable Story Status View.
///
/// SSStoryStatus provides customizable Story Status View.
public struct SSStoryStatus: View {
    
    // MARK: - Vars & Lets
    @State var storyViewModel: StoryViewModel
    
    // MARK: - Body
    public var body: some View {
        ProfileListView { user in
            ProfileView(user: user)
        }
        .fullScreenCover(isPresented: $storyViewModel.isStoryPresented) {
            StoryView()
        }
        .environment(storyViewModel)
    }
    
    // MARK: - Initializer
    /// Initialize SSStoryStatus view with ``UserModel`` list.
    /// - Parameters:
    ///   - users: The user list to display.
    ///   - sorted: If true the users with all stories seen based on
    ///   ``UserModel/isAllStoriesSeen`` will be moved to the end of the list.
    ///   - date: A date object for cache cleaning. Caches older than this date will be removed.
    ///   Profile cache won't be cleared.
    ///   Default cache clearing time is 24 hours old.
    public init(
        users: [UserModel],
        sorted: Bool = false,
        cacheExpire date: Date? = Dates.defaultCacheExpiry
    ) {
        storyViewModel = StoryViewModel(userList: users, sorted: sorted)
        clearCache(date: date)
    }
}

// MARK: - Public Methods
extension SSStoryStatus {
    
    // MARK: - Public Methods
    /// Change image cache implementation.
    ///
    /// There are two default implementations available ``StorageImageCache`` and ``NSImageCache``.
    ///
    /// NSImageCache cache images into `NSCache`. Cache will be cleared each time application is closed.
    ///
    /// StorageImageCache stores the cached images into file system. Cache can be cleared by passing date object to `cacheExpire` parameter in ``init(users:sorted:cacheExpire:)``.
    ///
    /// You can also provide custom implementation of ImageCache by confirming to ``ImageCache`` protocol.
    ///
    /// - Parameter cache: The image cache to use.
    /// - Returns: A new instance that uses given cache.
    public func changeImageCache<T: ImageCache>(_ cache: T) -> Self {
        ImageCacheManager.shared.changeCache(cache)
        return self
    }
}

// MARK: - Private Methods
extension SSStoryStatus {
    
    private func clearCache(date: Date?) {
        guard let date else { return }
        ImageCacheManager.shared.clearCache(olderThan: date)
        VideoCacheManager.shared.clearCache(olderThan: date)
    }
}
