//
//  View+Extension.swift
//  SSStoryStatus
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

// MARK: - Profile Style
extension View {
    
    public func profileListStyle<S: ProfileListStyle>(_ style: S) -> some View {
        environment(\.profileListStyle, AnyProfileListStyle(style))
    }
    
    public func profileStyle<S: ProfileStyle>(_ style: S) -> some View {
        environment(\.profileStyle, AnyProfileStyle(style))
    }
}

// MARK: - StoryView Style
extension View {
    
    public func storyStyle<S1: StoryHeaderStyle, S2: StoryFooterStyle>(headerStyle: S1 = .automatic, footerStyle: S2 = .automatic, progressBarStyle: ProgressBarStyle = .init()) -> some View {
        environment(\.storyHeaderStyle, AnyStoryHeaderStyle(headerStyle))
            .environment(\.storyFooterStyle, AnyStoryFooterStyle(footerStyle))
            .environment(\.progressBarStyle, progressBarStyle)
    }
    
    // MARK: - Emoji Style
    public func emoji<S: EmojiStyle>(
        _ emojis: [String] = Strings.emojis,
        style: S = .automatic,
        isEnabled: Bool = true,
        onSelect: @escaping EmojiSelectAction
    ) -> some View {
        let configuration = EmojiStyle.Configuration(emojis: emojis, enabled: isEnabled, onSelect: onSelect)
        
        return environment(\.emojiStyleConfiguration, configuration)
            .emojiStyle(style)
    }
    
    public func emojiStyle<S: EmojiStyle>(_ style: S) -> some View {
        environment(\.emojiStyle, AnyEmojiStyle(style))
    }
    
    // MARK: - Message Style
    public func messageField<S: MessageStyle>(
        placeholder: Text? = nil,
        style: S = .automatic,
        onSend: @escaping MessageSendAction
    ) -> some View {
        var configuration = MessageStyleConfiguration(onSend: onSend)
        
        if let placeholder {
            configuration.placeholder = placeholder
        }
        
        return environment(\.messageStyleConfiguration, configuration)
            .messageStyle(style)
    }
    
    public func messageStyle<S: MessageStyle>(_ style: S) -> some View {
        environment(\.messageStyle, AnyMessageStyle(style))
    }
}

// MARK: - View Extensions
extension View {
    
    // MARK: - Scale
    @ViewBuilder
    func scale(contentMode: ContentMode) -> some View {
        if contentMode == .fill {
            GeometryReader { geo in
                self
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
        } else {
            self
                .scaledToFit()
        }
    }
}
