//
//  StoryView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

struct StoryView: View {
    
    // MARK: - Vars & Lets
    @Environment(StoryViewModel.self) private var storyViewModel: StoryViewModel
    
    // MARK: - Body
    var body: some View {
        @Bindable var bindableViewModel = storyViewModel
        
        ZStack {
            TabView(selection: $bindableViewModel.currentUser) {
                ForEach(storyViewModel.userList) { user in
                    StoryDetailView(currentUser: user)
                        .tag(user as UserModel?)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .preferredColorScheme(.dark)
    }
}
