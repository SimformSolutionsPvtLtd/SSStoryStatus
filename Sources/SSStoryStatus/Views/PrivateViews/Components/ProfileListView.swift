//
//  ProfileListView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 16/11/23.
//

import SwiftUI

struct ProfileListView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.profileListStyle) private var profileListStyle
    @Environment(StoryViewModel.self) private var storyViewModel
    @ViewBuilder var content: (UserModel) -> ProfileListStyle.Configuration.Content
    
    private var configuration: ProfileListStyle.Configuration {
        ProfileListStyle.Configuration(users: storyViewModel.userList, content: content) { user in
            storyViewModel.viewStory(of: user)
        }
    }
    
    // MARK: - Body
    var body: some View {
        profileListStyle.makeBody(configuration: configuration)
    }
    
    // MARK: - Initializer
    init<Profile: View>(@ViewBuilder content: @escaping (UserModel) -> Profile) {
        self.content = { user in
            ProfileListStyle.Configuration.Content(content(user))
        }
    }
}

// MARK: - Typealias
public typealias UserSelectAction = (_ user: UserModel) -> Void
