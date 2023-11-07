//
//  StoryFooterView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 16/11/23.
//

import SwiftUI

struct StoryFooterView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.storyFooterStyle) private var storyFooterStyle
    @FocusState private var focused: Bool
    let user: UserModel
    let storyIndex: Int
    
    private var configuration: StoryFooterStyle.Configuration {
        .init(story: user.stories[storyIndex],
              reaction: .init(StoryReactionView(focused: $focused, user: user, storyIndex: storyIndex)))
    }
    
    // MARK: - Body
    public var body: some View {
        storyFooterStyle.makeBody(configuration: configuration, focused: $focused)
    }
}

// MARK: - Preview
#Preview {
    StoryFooterView(user: mockData[0], storyIndex: 0)
}
