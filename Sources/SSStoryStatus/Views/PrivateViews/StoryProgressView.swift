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
    @Environment(\.progressBarStyle) private var style
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { proxy in
            HStack(spacing: getSpacing(for: proxy)) {
                ForEach(userViewModel.progressModels) { story in
                    LinearProgressView(progress: story.progress, total: story.totalDuration)
                }
            }
        }
        .frame(height: style.height)      
    }
    
    // MARK: - Methods
    private func getSpacing(for proxy: GeometryProxy) -> CGFloat {
        let progressBarWidth = proxy.size.width / CGFloat(userViewModel.progressModels.count)
        let spacing = (progressBarWidth * style.preferredSpacingPercentage) / 100
        return spacing.clamped(to: style.spacingBound)
    }
}
