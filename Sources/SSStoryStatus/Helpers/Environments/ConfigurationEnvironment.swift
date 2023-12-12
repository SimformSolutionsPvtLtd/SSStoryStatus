//
//  ConfigurationEnvironment.swift
//
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

// MARK: - EmojiStyle Key
struct EmojiStyleConfigurationEnvironment: EnvironmentKey {

    static var defaultValue = EmojiStyle.Configuration()
}

// MARK: - EmojiStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var emojiStyleConfiguration: EmojiStyle.Configuration {
        get { self[EmojiStyleConfigurationEnvironment.self] }
        set { self[EmojiStyleConfigurationEnvironment.self] = newValue }
    }
}

// MARK: - MessageStyle Key
struct MessageStyleConfigurationEnvironment: EnvironmentKey {
    
    static var defaultValue = MessageStyle.Configuration()
}

// MARK: - MessageStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var messageStyleConfiguration: MessageStyle.Configuration {
        get { self[MessageStyleConfigurationEnvironment.self] }
        set { self[MessageStyleConfigurationEnvironment.self] = newValue }
    }
}
