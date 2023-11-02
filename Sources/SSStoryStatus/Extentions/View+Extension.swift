//
//  View+Extension.swift
//
//
//  Created by Krunal Patel on 03/11/23.
//

import SwiftUI

// MARK: - Action Keys View Extension
extension View {
    
    public func onStorySeen(action: StorySeenAction?) -> some View {
        environment(\.storySeenAction, action)
    }
}

// MARK: - ProfileListView Style
extension View {
    
    public func profileListStyle(_ style: ProfileListStyle) -> some View {
        environment(\.profileStyle, style)
    }
}

// MARK: - StoryView Style
extension View {
    
    public func storyStyle(_ style: StoryStyle) -> some View {
        environment(\.storyStyle, style)
    }
}
