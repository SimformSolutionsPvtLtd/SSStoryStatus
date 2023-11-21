//
//  StoryView.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

struct StoryView: View {
    
    @Environment(StoryViewModel.self) private var storyViewModel: StoryViewModel
    
    var body: some View {
        @Bindable var bindableViewModel = storyViewModel
        
        ZStack {
            TabView(selection: $bindableViewModel.currentUser.id) {
                ForEach(storyViewModel.userList) { user in
                    StoryDetailView(user: user)
                        .tag(user.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    StoryView()
        .environment(StoryViewModel(userList: mockData))
}
