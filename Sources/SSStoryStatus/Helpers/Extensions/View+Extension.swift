//
//  View+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 03/11/23.
//

import SwiftUI

// MARK: - Action Keys View Extension
extension View {
    
    /// Sets the action to perform when story is seen.
    ///
    /// You will get callback whenever any story is seen by user. The callback includes ``UserModel`` and
    /// `index` value of current seen story. By using which you can get ``StoryModel`` object.
    ///
    /// ```swift
    /// struct MyView: View {
    ///     var body: some View {
    ///         SSStoryStatus(users: users)
    ///             .onStorySeen { user, storyIndex in
    ///                 print("Seen", user.name, user.stories[storyIndex].mediaURL)
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter action: A closure to execute when the user see story.
    /// - Returns: New view with action implemented.
    public func onStorySeen(action: StorySeenAction?) -> some View {
        environment(\.storySeenAction, action)
    }
}

// MARK: - Profile Style
extension View {
    
    /// Sets the style for profile listing in view hierarchy.
    ///
    /// Use this modifier on ``SSStoryStatus`` instance to set a style that defines
    /// how the profiles should be listed on screen.
    ///
    /// ### Styling profile listing in hierarchy
    ///
    /// You can set a style for all ``SSStoryStatus`` instances within a
    /// view hierarchy by applying modifier to parent view. For example, you can
    /// apply the ``ProfileListStyle/automatic`` with horizontal spacing
    /// of 22 to an `VStack`:
    ///
    /// ```swift
    /// VStack {
    ///     SSStoryStatus(users: firstUserList)
    ///     SSStoryStatus(users: secondUserList)
    /// }
    /// .profileListStyle(.automatic.horizontalSpacing(22))
    /// ```
    ///
    /// ### Automatic styling
    ///
    /// By default it uses ``ProfileListStyle/automatic`` with default style values.
    /// You can customize properties like `horizontal spacing` with ``DefaultProfileListStyle/horizontalSpacing(_:)``.
    ///
    /// - Parameter style: The profile list style to set. Use built-in value
    /// like ``ProfileListStyle/automatic`` or custom style that conforms
    /// to ``ProfileListStyle`` protocol.
    /// - Returns: A view that uses the specified profile list style for itself
    ///   and its child views.
    public func profileListStyle<S: ProfileListStyle>(_ style: S) -> some View {
        environment(\.profileListStyle, AnyProfileListStyle(style))
    }
    
    /// Sets the style for profile view in profile listing.
    /// 
    /// Use this modifier on ``SSStoryStatus`` instance to set a style that defines
    /// how the profile should be look like.
    /// 
    /// ### Styling profile view in hierarchy
    /// 
    /// You can set a style for all ``SSStoryStatus`` instances within a
    /// view hierarchy by applying modifier to parent view. For example, you can
    /// apply the ``ProfileStyle/automatic`` with width and height of 80
    /// to an `VStack`:
    ///
    /// ```swift
    /// VStack {
    ///     SSStoryStatus(users: firstUserList)
    ///     SSStoryStatus(users: secondUserList)
    /// }
    /// .profileStyle(.automatic.profileSize(width: 80, height: 80))
    /// ```
    /// 
    /// ### Automatic styling
    /// 
    /// By default it uses ``ProfileStyle/automatic`` with default style values.
    /// You can customize properties with methods available in ``DefaultProfileStyle``.
    /// 
    /// - Parameter style: The profile style to set. Use built-in value like
    /// ``ProfileStyle/automatic`` or custom style that conforms to
    /// ``ProfileStyle`` protocol.
    /// - Returns: A view that uses the specified profile list style for itself
    ///   and its child views.
    public func profileStyle<S: ProfileStyle>(_ style: S) -> some View {
        environment(\.profileStyle, AnyProfileStyle(style))
    }
}

// MARK: - StoryView Style
extension View {
    
    /// Sets the style for story view appearance.
    /// 
    /// Use this modifier on ``SSStoryStatus`` instance to set a style that defines
    /// how the story should be look like. You can provide style for different component of story
    /// like header, footer and progress bar style.
    /// 
    /// ### Styling story view in hierarchy
    /// 
    /// You can set a style for all ``SSStoryStatus`` instances within a view
    /// hierarchy by applying modifier to parent view. For example, you can apply the
    /// ``StoryHeaderStyle/automatic`` with ``DefaultStoryHeaderStyle/dismissImage(_:)``
    /// to change the close button image and provide gradient color to progress bar.
    /// 
    /// ```swift
    /// VStack {
    ///     SSStoryStatus(users: firstUserList)
    ///     SSStoryStatus(users: secondUserList)
    /// }
    /// .storyStyle(
    ///     headerStyle: .automatic
    ///         .dismissImage(Image(systemName: "xmark")),
    ///     progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing))
    /// )
    /// ```
    /// 
    /// ### Automatic styling
    /// 
    /// - By default the header is styled using ``StoryHeaderStyle/automatic`` with the default
    /// values. You can customize the appearance using methods available in ``DefaultStoryHeaderStyle``.
    /// 
    /// - By default the footer is styled using ``StoryFooterStyle/automatic`` with the default
    /// values. You can customize the appearance using methods available in ``DefaultStoryFooterStyle``.
    /// 
    /// - Progress bar use ``ProgressBarStyle`` instance for styling. You can customize it with available
    /// methods in `ProgressBarStyle` or create new instance with ``ProgressBarStyle/init(foreground:background:height:)``
    ///  with required values.
    /// 
    /// - Parameters:
    ///   - headerStyle: A header style to use for styling header in the story view.
    ///   - footerStyle: A footer style to use for styling footer in the story view.
    ///   - progressBarStyle: A progress bar style to use for styling progress bar in the story view.
    /// - Returns: A view that uses the specified profile list style for itself
    ///   and its child views.
    public func storyStyle<S1: StoryHeaderStyle, S2: StoryFooterStyle>(headerStyle: S1 = .automatic, footerStyle: S2 = .automatic, progressBarStyle: ProgressBarStyle = .init()) -> some View {
        environment(\.storyHeaderStyle, AnyStoryHeaderStyle(headerStyle))
            .environment(\.storyFooterStyle, AnyStoryFooterStyle(footerStyle))
            .environment(\.progressBarStyle, progressBarStyle)
    }
    
    // MARK: - Emoji Style
    /// Sets the reaction view with given emojis and style.
    ///
    /// Use this modifier on ``SSStoryStatus`` instance to set configuration for emoji view and a
    /// style that defines how the emoji view should be look like. You can disable this view by setting
    /// `isEnabled` parameter to false.
    ///
    /// ```swift
    /// SSStoryStatus(users: mockData)
    ///     .emoji(["😂", "🔥", "😭", "😍", "😡"], style: .automatic(emojiSize: 20))) { emoji, _, _ in
    ///         print("Selected - ", emoji)
    ///     }
    /// ```
    ///
    /// If you just want to customize style of emoji view please use ``emojiStyle(_:)``.
    ///
    /// - Parameters:
    ///   - emojis: List of emojis to display in reaction view.
    ///   - style: The style to apply on emojis view.
    ///   - isEnabled: If false the emoji reactions will be disabled.
    ///   - onSelect: The action to perform when any emoji is pressed.
    /// - Returns: A view that uses the specified emoji configuration for itself
    ///   and its child views.
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
    
    /// Sets the style for emoji view in the story view.
    ///
    /// Use this modifier on ``SSStoryStatus`` instance to set a style that defines
    /// how the emojis view should be look like.
    /// 
    /// ### Styling emoji view in hierarchy
    /// 
    /// You can set a style for all ``SSStoryStatus`` instances within a
    /// view hierarchy by applying modifier to parent view. For example, you can
    /// apply the ``EmojiStyle/automatic`` with emoji size of 20 to an `VStack`:
    /// 
    /// ```swift
    /// VStack {
    ///     SSStoryStatus(users: firstUserList)
    ///     SSStoryStatus(users: secondUserList)
    /// }
    /// .emojiStyle(.automatic.emojiSize(20))
    /// ```
    /// 
    /// ### Automatic styling
    /// 
    /// By default it uses ``EmojiStyle/automatic`` with default style values.
    /// You can customize properties with methods available in ``DefaultEmojiStyle``.
    /// 
    /// - Parameter style: The emoji style to set. Use built-in value like
    /// ``EmojiStyle/automatic`` or custom style that conforms to
    /// ``EmojiStyle`` protocol.
    /// - Returns: A view that uses the specified profile list style for itself
    ///   and its child views.
    public func emojiStyle<S: EmojiStyle>(_ style: S) -> some View {
        environment(\.emojiStyle, AnyEmojiStyle(style))
    }
    
    // MARK: - Message Style

    /// Sets the message field with placeholder and style.
    ///
    /// Use this modifier on ``SSStoryStatus`` instance to set configuration and style for
    /// message field in story view.
    ///
    /// - Parameters:
    ///   - placeholder: The text that will be displayed as placeholder for message field.
    ///   - style: The style to apply on message field.
    ///   - onSend: The action to perform when message is send.
    /// - Returns: A view that uses the specified message field configuration for itself
    ///   and its child views.
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
    
    /// Sets the style for message field view in the story view.
    ///
    /// Use this modifier on ``SSStoryStatus`` instance to set a style that defines
    /// how the message field should be look like in story view.
    ///
    /// ### Styling message view in hierarchy
    ///
    /// You can set a style for all ``SSStoryStatus`` instances within a
    /// view hierarchy by applying modifier to parent view. For example, you can
    /// apply the ``MessageStyle/automatic`` with font size of 18 to an `VStack`:
    ///
    /// ```swift
    /// VStack {
    ///     SSStoryStatus(users: firstUserList)
    ///     SSStoryStatus(users: secondUserList)
    /// }
    /// .emojiStyle(.automatic.messageFont(.system(size: 18))
    /// ```
    ///
    /// ### Automatic styling
    ///
    /// By default it uses ``MessageStyle/automatic`` with default style values.
    /// You can customize properties with methods available in ``DefaultMessageStyle``.
    ///
    /// - Parameter style: The message style to set. Use built-in value like
    /// ``MessageStyle/automatic`` or custom style that conforms to
    /// ``MessageStyle`` protocol.
    /// - Returns: A view that uses the specified profile list style for itself
    ///   and its child views.
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
