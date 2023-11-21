//
//  ProfileListView.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

struct ProfileListView: View {
    
    @Environment(StoryViewModel.self) private var storyViewModel: StoryViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: Sizes.profileViewSpace) {
                ForEach(storyViewModel.userList) { user in
                    UserView(user: user)
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

#Preview {
    ProfileListView()
        .previewLayout(.sizeThatFits)
        .environment(StoryViewModel(userList: mockData))
}
