//
//  StoryProgressView.swift
//
//
//  Created by Krunal Patel on 30/10/23.
//

import SwiftUI

struct StoryProgressView: View {
    
    // MARK: - Vars & Lets
    @Environment(UserViewModel.self) private var userViewModel
    @Environment(\.storyStyle) private var storyStyle
    
    // MARK: - Body
    var body: some View {
        
        HStack(spacing: Sizes.progressBarSpacing) {
            
            ForEach(userViewModel.progressModels) { story in
                ProgressView(value: story.progress, total: story.totalDuration)
                    .tint(storyStyle.progressbarColor)
                    .progressViewStyle(.linear)
            }
        }
        .onDisappear {
            userViewModel.updateProgressState(isPaused: true)
        }
    }
}

// MARK: - Preview
#Preview {
    let userViewModel = UserViewModel()
    userViewModel.updateUser(user: mockData[0])
    return StoryProgressView()
        .environment(userViewModel)
}
