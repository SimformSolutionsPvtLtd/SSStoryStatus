//
//  StyleEnvironment.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileListStyle Key
struct ProfileListStyleEnvironment: EnvironmentKey {
    
    static var defaultValue = AnyProfileListStyle(.automatic)
}

// MARK: - ProfileListStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var profileListStyle: AnyProfileListStyle {
        get { self[ProfileListStyleEnvironment.self] }
        set { self[ProfileListStyleEnvironment.self] = newValue }
    }
}

// MARK: - ProfileStyle Key
struct ProfileStyleEnvironment: EnvironmentKey {
    
    static var defaultValue = AnyProfileStyle(.automatic)
}

// MARK: - ProfileStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var profileStyle: AnyProfileStyle {
        get { self[ProfileStyleEnvironment.self] }
        set { self[ProfileStyleEnvironment.self] = newValue }
    }
}

// MARK: - StoryHeaderStyle Key
struct StoryHeaderStyleEnvironment: EnvironmentKey {
    
    static var defaultValue: AnyStoryHeaderStyle = AnyStoryHeaderStyle(.automatic)
}

// MARK: - StoryHeaderStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var storyHeaderStyle: AnyStoryHeaderStyle {
        get { self[StoryHeaderStyleEnvironment.self] }
        set { self[StoryHeaderStyleEnvironment.self] = newValue }
    }
}

// MARK: - ProgressBarStyle Key
struct ProgressBarStyleEnvironment: EnvironmentKey {
    
    static var defaultValue: ProgressBarStyle = ProgressBarStyle()
}

// MARK: - ProgressBarStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var progressBarStyle: ProgressBarStyle {
        get { self[ProgressBarStyleEnvironment.self] }
        set { self[ProgressBarStyleEnvironment.self] = newValue }
    }
}

// MARK: - StoryFooterStyle Key
struct StoryFooterStyleEnvironment: EnvironmentKey {
    
    static var defaultValue: AnyStoryFooterStyle = AnyStoryFooterStyle(.automatic)
}

// MARK: - StoryFooterStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var storyFooterStyle: AnyStoryFooterStyle {
        get { self[StoryFooterStyleEnvironment.self] }
        set { self[StoryFooterStyleEnvironment.self] = newValue }
    }
}

// MARK: - EmojiStyle Key
struct EmojiStyleEnvironment: EnvironmentKey {
    
    static var defaultValue = AnyEmojiStyle(.automatic)
}

// MARK: - EmojiStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var emojiStyle: AnyEmojiStyle {
        get { self[EmojiStyleEnvironment.self] }
        set { self[EmojiStyleEnvironment.self] = newValue }
    }
}

// MARK: - MessageStyle Key
struct MessageStyleEnvironment: EnvironmentKey {
    
    static var defaultValue = AnyMessageStyle(.automatic)
}

// MARK: - MessageStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var messageStyle: AnyMessageStyle {
        get { self[MessageStyleEnvironment.self] }
        set { self[MessageStyleEnvironment.self] = newValue }
    }
}

// MARK: - StoryStyle Key
struct StoryStyleEnvironment: EnvironmentKey {
    
    static var defaultValue: StoryStyle = StoryStyle()
}

// MARK: - StoryStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var storyStyle: StoryStyle {
        get { self[StoryStyleEnvironment.self] }
        set { self[StoryStyleEnvironment.self] = newValue }
    }
}
