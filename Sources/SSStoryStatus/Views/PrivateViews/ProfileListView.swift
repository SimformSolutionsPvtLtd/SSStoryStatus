//
//  ProfileListView.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

struct ProfileListView<Content: View>: View {
    
    // MARK: - Vars & Lets
    @Environment(StoryViewModel.self) private var storyViewModel
    @Environment(\.profileStyle) private var profileStle
    @ViewBuilder var content: (UserModel) -> Content
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: profileStle.hSpacing) {
                ForEach(storyViewModel.userList) { user in
                    content(user)
                        .onTapGesture {
                            storyViewModel.viewStory(of: user)
                        }
                }
            }
            .fixedSize()
        }
        .padding(.vertical)
        .padding(.horizontal)
        .scrollClipDisabled()
    }
}

// MARK: - Preview
#Preview {
    ProfileListView { user in
        UserView(user: user)
    }
    .previewLayout(.sizeThatFits)
    .environment(StoryViewModel(userList: mockData))
}
