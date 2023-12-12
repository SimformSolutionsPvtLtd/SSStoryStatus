//
//  StoryFooterStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 16/11/23.
//

import SwiftUI

// MARK: - StoryFooterStyle Configuration
/// A configuration of a story header.
///
/// When you define a custom message field style that confirms to the
/// ``StoryHeaderStyle`` protocol, you use this configuration to create view
/// using ``StoryHeaderStyle/makeBody(configuration:imageModel:)`` method.
/// Method takes `StoryHeaderStyleConfiguration` as input that contains all required
/// informations to create message field.
public struct StoryFooterStyleConfiguration {
    
    // MARK: - Vars & Lets
    /// The story information to display.
    var story: StoryModel
    
    /// A reaction view containing text field and emojis.
    var reaction: Reaction
    
    // MARK: - Reaction View
    /// A type-erased reaction view.
    public struct Reaction : View {
        init<Content: View>(_ content: Content) {
          body = AnyView(content)
        }

        public var body: AnyView
    }
}

// MARK: - StoryFooterStyle
/// A appearance and behaviour of story footer.
///
/// To set the style pass and instance of type that confirms to `StoryFooterStyle` protocol
/// to `footerStyle` in
/// ``SwiftUI/View/storyStyle(_:headerStyle:footerStyle:progressBarStyle:)``.
///
/// You can use built-in style ``automatic`` with the default values or
/// with customization like ``DefaultStoryFooterStyle/captionColor(_:)``.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(footerStyle: .automatic.captionColor(.white))
/// ```
///
/// To create custom style, declare a type that confirms to `StoryFooterStyle` and
/// implement the required ``makeBody(configuration:focused:)`` method.
///
/// ```swift
/// struct MyStoryFooterStyle: StoryFooterStyle {
///     func makeBody(configuration: Configuration, focused: FocusState<Bool>.Binding) -> some View {
///         // Return a footer view.
///     }
/// }
/// ```
///
/// Inside the method, use `configuration` parameter, which is instance of
/// ``StoryFooterStyleConfiguration`` structure containing required informations
/// such as story information and reaction view.
///
/// To provide easy access to the new style, declare a corresponding static variable in an
/// extension to `StoryFooterStyle`.
///
/// ```swift
/// extension StoryFooterStyle where Self == MyStoryFooterStyle {
///     static var custom: MyStoryFooterStyle { .init() }
/// }
/// ```
///
/// You can then use it like:
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(footerStyle: .custom)
/// ```
public protocol StoryFooterStyle {
    
    /// A view that represents the appearance of a profile listing.
    ///
    /// SwiftUI inters this type automatically based on the `View` instance returned
    /// form ``makeBody(configuration:focused:)`` method.
    associatedtype Body : View
    
    /// Creates a view that represents the body of footer.
    ///
    /// Implement this method when defining custom style that confirms to
    /// ``StoryFooterStyle`` protocol. Use the `configuration` instance of
    /// ``StoryFooterStyleConfiguration`` to access required information.
    ///
    /// ```swift
    /// struct MyProfileStyle: ProfileStyle {
    ///     func makeBody(configuration: Configuration, focused: FocusState<Bool>.Binding) -> some View {
    ///         VStack {
    ///             if !focused.wrappedValue {
    ///                 Text(configuration.story.caption)
    ///             }
    ///
    ///             configuration.reaction
    ///         }
    ///     }
    /// }
    /// ```
    @ViewBuilder func makeBody(configuration: Self.Configuration, focused: FocusState<Bool>.Binding) -> Self.Body
    
    /// The properties of footer view.
    ///
    /// You receive a `configuration` parameter of this type -- which is an alias for the
    /// ``StoryFooterStyleConfiguration`` type -- when implementing
    /// ``makeBody(configuration:focused:)`` method for custom style.
    typealias Configuration = StoryFooterStyleConfiguration
}

// MARK: - Type Erased StoryFooterStyle
struct AnyStoryFooterStyle: StoryFooterStyle {
    
    private let _makeBody: (Configuration, FocusState<Bool>.Binding) -> AnyView
    
    init<S: StoryFooterStyle>(_ style: S) {
        _makeBody = { configuration, focused in
            AnyView(style.makeBody(configuration: configuration, focused: focused))
        }
    }
    
    func makeBody(configuration: Configuration, focused: FocusState<Bool>.Binding) -> some View {
        return _makeBody(configuration, focused)
    }
}

// MARK: - DefaultStoryFooterStyle
/// The default footer style.
///
/// Use the ``StoryFooterStyle/automatic`` to apply this style.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(footerStyle: .automatic)
/// ```
public struct DefaultStoryFooterStyle: StoryFooterStyle {
    
    // MARK: - Vars & Lets
    /// The font for caption text.
    public var captionFont: Font = Fonts.storyCaption
    
    /// The color for caption text.
    public var captionColor: Color = Color(.label)
    
    // MARK: - Body
    /// Creates a view containing the body of a footer view.
    ///
    /// The default implementation for ``StoryFooterStyle`` is implemented by default.
    /// The system calls this method for each footer view when required.
    ///
    /// - Parameters:
    ///   - configuration: The properties of user for footer view.
    ///   - focused: The focus state of message text field.
    /// - Returns: A view containing profile appearance and behaviour.
    @ViewBuilder
    public func makeBody(configuration: Configuration, focused: FocusState<Bool>.Binding) -> some View {
        
        VStack {
            if !focused.wrappedValue {
                getCaptionView(configuration.story.caption)
            }
            
            configuration.reaction
        }
    }
}

// MARK: - Private Views
extension DefaultStoryFooterStyle {

    private func getCaptionView(_ caption: String) -> some View {
        Text(caption)
            .font(captionFont)
            .foregroundStyle(captionColor)
            .shadow(color: .black, radius: 10)
    }
}

// MARK: - Public Methods
extension DefaultStoryFooterStyle {
    
    // MARK: - Colors
    /// Sets the text color for caption.
    ///
    /// - Parameter color: The color to set on caption text.
    /// - Returns: A new style with given caption text color.
    public func captionColor(_ color: Color) -> Self {
        var copy = self
        copy.captionColor = color
        return copy
    }
    
    // MARK: - Fonts
    /// Sets new font for caption text.
    ///
    /// - Parameters:
    ///   - font: The font to set on caption text.
    /// - Returns: A new style with given configurations.
    public func captionFont(_ font: Font) -> Self {
        var copy = self
        copy.captionFont = font
        return copy
    }
}

// MARK: - DefaultStoryFooterStyle Variable
extension StoryFooterStyle where Self == DefaultStoryFooterStyle {
    
    /// A story footer view style containing default style appearance and behaviour.
    public static var automatic: DefaultStoryFooterStyle { .init() }
}
