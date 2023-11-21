//
//  SSStoryStatus.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

public struct SSStoryStatus: View {
    
    @State var storyViewModel: StoryViewModel
    
    public var body: some View {
        ProfileListView()
            .fullScreenCover(isPresented: $storyViewModel.isStoryPresented) {
                StoryView()
            }
            .environment(storyViewModel)
    }
    
    public init (users: [UserModel]) {
        storyViewModel = StoryViewModel(userList: users)
    }
}

#Preview {
    SSStoryStatus(users: mockData)
}
