//
//  File.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

// MARK: - EmojiStyle Configuration
/// A configuration of a emoji view.
///
/// When you define a custom emoji style that confirms to the ``EmojiStyle``
/// protocol, you use this configuration to create view using
/// ``EmojiStyle/makeBody(configuration:user:storyIndex:)`` method.
/// Method takes `EmojiStyleConfiguration` as input that contains all the
/// required informations to create emoji view.
public struct EmojiStyleConfiguration {
    
    // MARK: - Vars & Lets
    /// A list of emojis to display.
    public var emojis: [String] = Strings.emojis
    
    /// A boolean value that represents whether the emoji reaction should be
    ///  enabled or not.
    public var enabled: Bool = true
    
    /// A closure that is used to notify when emoji is pressed by user.
    public var onSelect: EmojiSelectAction?
}

// MARK: - EmojiStyle
/// A appearance and behaviour of emoji view.
///
/// You can configure the style using the ``SwiftUI/View/emojiStyle(_:)``
/// modifier.
///
/// You can use built-in style ``automatic`` with the default values or customize with
/// available methods in ``DefaultEmojiStyle``.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .emojiStyle(.automatic)
/// ```
///
/// To create custom style, declare a type that confirms to `EmojiStyle` and
/// implement the required ``makeBody(configuration:user:storyIndex:)`` method.
///
/// ```swift
/// struct HorizontalProfileListStyle: EmojiStyle {
///     func makeBody(configuration: Configuration) -> some View {
///         // Return a view listing emojis with horizontal appearance and behaviour.
///     }
/// }
/// ```
///
/// Inside the method, use `configuration` parameter, which is instance of
/// ``EmojiStyleConfiguration`` structure containing required informations
/// such as list of emojis and action to perform on selection.
///
/// To provide easy access to the new style, declare a corresponding static variable in an
/// extension to `EmojiStyle`.
///
/// ```swift
/// extension EmojiStyle where Self == HorizontalEmojiStyle {
///     static var horizontal: HorizontalStyle { .init() }
/// }
/// ```
///
/// You can then use it like:
///
/// ```swift
/// SSStoryStatus(users: users)
///     .emojiStyle(.horizontal)
/// ```
public protocol EmojiStyle {
    
    /// A view that represents the appearance of a emojis view.
    ///
    /// SwiftUI inters this type automatically based on the `View` instance returned
    /// form ``makeBody(configuration:user:storyIndex:)`` method.
    associatedtype Body : View
    
    /// Creates a view that represents the body of emoji view.
    ///
    /// Implement this method when defining custom style that confirms to
    /// ``EmojiStyle`` protocol. Use the `configuration` instance of
    /// ``EmojiStyleConfiguration`` to access required information.
    ///
    /// ```swift
    /// struct HorizontalEmojiStyle: EmojiStyle {
    ///     func makeBody(configuration: Configuration) -> some View {
    ///         ScrollView {
    ///             HStack {
    ///                 ForEach(configuration.emojis) { emoji in
    ///                     Button {
    ///                         onSelect?(emoji)
    ///                     } label: {
    ///                         Text(emoji)
    ///                     }
    ///                 }
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// Use ``EmojiStyleConfiguration/emojis`` to get list of emoji and implement call
    /// ``ProfileListStyleConfiguration/onSelect`` to notify that the emoji is pressed.
    @ViewBuilder func makeBody(configuration: Self.Configuration, user: UserModel, storyIndex: Int) -> Self.Body
    
    /// The properties of emoji view.
    ///
    /// You receive a `configuration` parameter of this type -- which is an alias for the
    /// ``EmojiStyleConfiguration`` type -- when implementing
    /// ``makeBody(configuration:user:storyIndex:)`` method for custom style.
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
/// The default emoji view style.
///
/// Use the ``EmojiStyle/automatic`` to apply this style.
///
/// ```swift
/// SSStoryStatus(users: users)
///     .emojiStyle(.automatic)
/// ```
public struct DefaultEmojiStyle: EmojiStyle {
    
    // MARK: - Vars & Lets
    /// The maximum number of column for emoji in single row.
    public var maxColumn: Int
    
    /// The size of emoji.
    public var emojiSize: CGFloat
    
    /// Creates a view that represents the body of a emoji view and behaviour.
    ///
    /// The default implementation for ``EmojiStyle`` is implemented by default.
    /// The system calls this method for each `EmojiView` when required.
    ///
    /// - Parameter configuration: The properties of emojis.
    /// - Returns: A view containing emoji view appearance and behaviour.
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
    
    /// Sets the number of maximum emoji in single row.
    /// 
    /// - Parameter count: The number of column to allow.
    /// - Returns: A style with new maximum column set.
    public func maxColumn(_ count: Int) -> Self {
        var copy = self
        copy.maxColumn = count
        return copy
    }
    
    /// Sets the size of emoji.
    ///
    /// - Parameter size: The size of emoji.
    /// - Returns: A new style with given emoji size.
    public func emojiSize(_ size: CGFloat) -> Self {
        var copy = self
        copy.emojiSize = size
        return copy
    }
}

// MARK: - EmojiStyle extension for DefaultEmojiStyle
extension EmojiStyle where Self == DefaultEmojiStyle {
    
    /// A default emoji style containing default style appearance and behaviour.
    public static var automatic: DefaultEmojiStyle { automatic() }
    
    /// A default emoji style containing default style and accepts custom values.
    public static func automatic(
        maxColumn: Int = Sizes.maxEmojiColumn,
        emojiSize: CGFloat = Sizes.emojiSize
    ) -> DefaultEmojiStyle { DefaultEmojiStyle(maxColumn: maxColumn, emojiSize: emojiSize) }
}
