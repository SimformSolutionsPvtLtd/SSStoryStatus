//
//  ConfigurationEnvironment.swift
//
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

// MARK: - StoryStyle Key
struct EmojiStyleConfigurationEnvironment: EnvironmentKey {

    static var defaultValue = EmojiStyle.Configuration()
}

// MARK: - StoryStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var emojiStyleConfiguration: EmojiStyle.Configuration {
        get { self[EmojiStyleConfigurationEnvironment.self] }
        set { self[EmojiStyleConfigurationEnvironment.self] = newValue }
    }
}

// MARK: - StoryStyle Key
struct MessageStyleConfigurationEnvironment: EnvironmentKey {
    
    static var defaultValue = MessageStyle.Configuration()
}

// MARK: - StoryStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var messageStyleConfiguration: MessageStyle.Configuration {
        get { self[MessageStyleConfigurationEnvironment.self] }
        set { self[MessageStyleConfigurationEnvironment.self] = newValue }
    }
}
