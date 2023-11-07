//
//  StoryProgressView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 30/10/23.
//

import SwiftUI

struct StoryProgressView: View {
    
    // MARK: - Vars & Lets
    @Environment(UserViewModel.self) private var userViewModel
    
    // MARK: - Body
    var body: some View {
        
        HStack(spacing: Sizes.progressBarSpacing) {
            ForEach(userViewModel.progressModels) { story in
                LinearProgressView(progress: story.progress, total: story.totalDuration)
            }
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
