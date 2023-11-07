//
//  SSStoryStatus.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

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
    public func changeImageCache<T: ImageCache>(cache: T) -> Self {
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

// MARK: - Preview
#Preview {
    SSStoryStatus(users: mockData)
}
