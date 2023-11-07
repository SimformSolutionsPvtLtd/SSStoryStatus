//
//  File.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

// MARK: - EmojiStyle Configuration
public struct EmojiStyleConfiguration {
    
    var emojis: [String] = Strings.emojis
    var enabled: Bool = true
    var onSelect: EmojiSelectAction?
}

// MARK: - EmojiStyle
public protocol EmojiStyle {
    
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration, user: UserModel, storyIndex: Int) -> Self.Body
    
    typealias Configuration = EmojiStyleConfiguration
}

// MARK: - Type Erased EmojiStyle
struct AnyEmojiStyle: EmojiStyle {
    
    private let _makeBody: (Configuration, UserModel, Int) -> AnyView
    
    init<S: EmojiStyle>(_ style: S) {
        _makeBody = { configuration, user, storyIndex in
            AnyView(style.makeBody(configuration: configuration, user: user, storyIndex: storyIndex))
        }
    }
    
    func makeBody(configuration: Configuration, user: UserModel, storyIndex: Int) -> some View {
        return _makeBody(configuration, user, storyIndex)
    }
}

// MARK: - DefaultEmojiStyle
public struct DefaultEmojiStyle: EmojiStyle {
    
    // MARK: - Vars & Lets
    var maxColumn: Int
    var emojiSize: CGFloat
    
    public func makeBody(configuration: Configuration, user: UserModel, storyIndex: Int) -> some View {
        let total = configuration.emojis.count
        let remaining = total % maxColumn
        let firstPart = configuration.emojis.dropLast(remaining)
        let secondPart = configuration.emojis.dropFirst(total - remaining)
        
        VStack(spacing: Sizes.emojiVSpacing) {
            LazyVGrid(columns: getGridItems(count: total), spacing: Sizes.emojiVSpacing) {
                ForEach(firstPart, id: \.self) { emoji in
                    getEmojiView(emoji: emoji, user: user, storyIndex: storyIndex, onSelect: configuration.onSelect)
                }
            }
            
            HStack {
                ForEach(secondPart, id: \.self) { emoji in
                    Spacer()
                    getEmojiView(emoji: emoji, user: user, storyIndex: storyIndex, onSelect: configuration.onSelect)
                }
                Spacer()
            }
            
        }
    }
}

// MARK: - Private Views
extension DefaultEmojiStyle {
    
    @ViewBuilder
    private func getEmojiView(emoji: String, user: UserModel, storyIndex: Int, onSelect: EmojiSelectAction?) -> some View {
        Button {
            onSelect?(emoji, user, storyIndex)
        } label: {
            Text(emoji)
                .font(.system(size: emojiSize))
        }
    }
    
    private func getGridItems(count: Int) -> [GridItem] {
        Array(repeating: GridItem(.flexible(maximum: Sizes.maxEmojiSpacing)),
              count: max(1, count.clamped(to: 1...maxColumn)))
    }
}

// MARK: - Public Methods
extension DefaultEmojiStyle {
    
    public func maxColumn(_ count: Int) -> Self {
        var copy = self
        copy.maxColumn = count
        return copy
    }
    
    public func emojiSize(_ size: CGFloat) -> Self {
        var copy = self
        copy.emojiSize = size
        return copy
    }
}

// MARK: - EmojiStyle extension for DefaultEmojiStyle
extension EmojiStyle where Self == DefaultEmojiStyle {
    
    public static var automatic: DefaultEmojiStyle { automatic() }
    
    public static func automatic(
        maxColumn: Int = Sizes.maxEmojiColumn,
        emojiSize: CGFloat = Sizes.emojiSize
    ) -> DefaultEmojiStyle { DefaultEmojiStyle(maxColumn: maxColumn, emojiSize: emojiSize) }
}



