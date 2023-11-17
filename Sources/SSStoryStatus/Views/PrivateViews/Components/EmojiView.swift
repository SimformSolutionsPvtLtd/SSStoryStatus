//
//  EmojiView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

struct EmojiView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.emojiStyle) private var emojiStyle
    @Environment(\.emojiStyleConfiguration) private var globalConfiguration
    let user: UserModel
    let storyIndex: Int
    var onSelect: EmojiSelectAction? = nil
    
    private var configuration: EmojiStyle.Configuration {
        var config = globalConfiguration
        config.onSelect = { emoji, user, storyIndex in
            onSelect?(emoji, user, storyIndex)
            globalConfiguration.onSelect?(emoji, user, storyIndex)
        }
        return config
    }
    
    // MARK: - Body
    var body: some View {
        emojiStyle.makeBody(configuration: configuration, user: user, storyIndex: storyIndex)
    }
}

// MARK: - Typealias
/// A closure that is called when emoji is pressed by user.
///
/// - Parameters:
///   - emoji: The emoji selected by user.
///   - user: The user containing story.
///   - storyIndex: The index of story.
public typealias EmojiSelectAction = (_ emoji: String, _ user: UserModel, _ storyIndex: Int) -> Void

// MARK: - Preview
#Preview {
    EmojiView(user: mockData[0], storyIndex: 0)
}
