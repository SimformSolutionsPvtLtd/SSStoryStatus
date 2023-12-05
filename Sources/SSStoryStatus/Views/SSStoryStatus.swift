//
//  SSStoryStatus.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

public struct SSStoryStatus<Profile: View>: View {
    
    // MARK: - Vars & Lets
    @State var storyViewModel: StoryViewModel
    @ViewBuilder public var profile: (UserModel) -> Profile
    
    // MARK: - Body
    public var body: some View {
        ProfileListView(content: profile)
        .fullScreenCover(isPresented: $storyViewModel.isStoryPresented) {
            StoryView()
        }
        .environment(storyViewModel)
    }
    
    public init(users: [UserModel], sorted: Bool = false, @ViewBuilder profile: @escaping (UserModel) -> Profile) {
        storyViewModel = StoryViewModel(userList: users, sorted: sorted)
        self.profile = profile
    }
}

// MARK: - Default Profile View
extension SSStoryStatus where Profile == UserView {
    
    public init(users: [UserModel], sorted: Bool = false) {
        self.init(users: users, sorted: sorted) { user in
            UserView(user: user)
        }
    }
}

// MARK: - Typealias
public typealias StorySeenAction = (_ user: UserModel, _ storyIndex: Int) -> Void

// MARK: - Preview
#Preview {
    SSStoryStatus(users: mockData) { user in
        UserView(user: user)
    }
}
