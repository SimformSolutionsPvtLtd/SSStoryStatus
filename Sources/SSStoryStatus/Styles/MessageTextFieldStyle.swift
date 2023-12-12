//
//  RoundedTextFieldStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

// MARK: - MessageStyle Configuration
/// A configuration of a message field.
///
/// When you define a custom message field style that confirms to the
/// ``MessageStyle`` protocol, you use this configuration to create view
/// using ``MessageStyle/makeBody(configuration:user:storyIndex:message:focused:)`` method.
/// Method takes `MessageStyleConfiguration` as input that contains all required
/// informations to create message field.
public struct MessageStyleConfiguration {
    
    // MARK: - Vars & Lets
    /// The placeholder value for message field.
    public var placeholder: Text = Text(Strings.messagePlaceholder)
        .font(Fonts.messagePlaceholderFont)
        .foregroundStyle(Colors.placeholderColor)
    
    /// The image used as send icon.
    public var sendIcon: Image = Image(systemName: Images.messageSend)
    
    /// A closure to notify the message is sent.
    /// When defining custom style make sure to call this action when send button is pressed.
    public var onSend: MessageSendAction?
}

// MARK: - MessageStyle
/// A appearance and behaviour of message field.
///
/// You can configure the style using the ``SwiftUI/View/messageStyle(_:)``
/// modifier.
///
/// You can use built-in style ``automatic`` with the default values or
/// with customization like ``DefaultMessageStyle/textColor(_:)``.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .messageStyle(.automatic)
/// ```
///
/// To create custom style, declare a type that confirms to `MessageStyle` and
/// implement the required ``makeBody(configuration:user:storyIndex:message:focused:)``
/// method.
///
/// ```swift
/// struct MyMessageStyle: MessageStyle {
///     func makeBody(configuration: Configuration, @Binding message: String, focused: FocusState<Bool>.Binding) -> some View {
///         // Return a view listing users with vertical appearance and behaviour.
///     }
/// }
/// ```
///
/// Inside the method, use `configuration` parameter, which is instance of
/// ``MessageStyleConfiguration`` structure containing required informations
/// such as placeholder and send action.
///
/// To provide easy access to the new style, declare a corresponding static variable in an
/// extension to `MessageStyle`.
///
/// ```swift
/// extension MessageStyle where Self == MyMessageStyle {
///     static var custom: MyMessageStyle { .init() }
/// }
/// ```
///
/// You can then use it like:
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .profileListStyle(.custom)
/// ```
public protocol MessageStyle {
    
    /// A view that represents the appearance of a profile listing.
    ///
    /// SwiftUI inters this type automatically based on the `View` instance returned
    /// form ``makeBody(configuration:user:storyIndex:message:focused:)``
    /// method.
    associatedtype Body : View
    
    /// Creates a view that represents the body of message field.
    ///
    /// Implement this method when defining custom style that confirms to
    /// ``MessageStyle`` protocol. Use the `configuration` instance of
    /// ``MessageStyleConfiguration`` to access required information.
    ///
    /// ```swift
    /// struct MyMessageStyle: MessageStyle {
    ///     func makeBody(configuration: Configuration, @Binding message: String, focused: FocusState<Bool>.Binding) -> some View {
    ///         HStack {
    ///             TextField(text: $message) {
    ///                 configuration.placeholder
    ///             }
    ///             .focused(focused)
    ///
    ///             Button {
    ///                 configuration.onSend?(message)
    ///                 message = ""
    ///                 focused.wrappedValue = false
    ///             } label: {
    ///                 configuration.sendIcon
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// Use the binding provided in ``makeBody(configuration:user:storyIndex:message:focused:)``
    /// for text field and assign focus to the text field so the story pause and resume behaviour work as expected.
    /// Make sure to call ``MessageStyleConfiguration/onSend`` to notify message is sent.
    @ViewBuilder func makeBody(configuration: Self.Configuration, user: UserModel, storyIndex: Int, message: Binding<String>, focused: FocusState<Bool>.Binding) -> Self.Body
    
    /// The properties of profile listing.
    ///
    /// You receive a `configuration` parameter of this type -- which is an alias for the
    /// ``MessageStyleConfiguration`` type -- when implementing
    /// ``makeBody(configuration:user:storyIndex:message:focused:)`` method
    /// for custom style.
    typealias Configuration = MessageStyleConfiguration
    
}

// MARK: - Type Erased MessageStyle
struct AnyMessageStyle: MessageStyle {
    
    private let _makeBody: (Configuration, UserModel, Int, Binding<String>, FocusState<Bool>.Binding) -> AnyView
    
    init<S: MessageStyle>(_ style: S) {
        _makeBody = { configuration, user, storyIndex, message, focused in
            AnyView(style.makeBody(configuration: configuration, user: user, storyIndex: storyIndex, message: message, focused: focused))
        }
    }
    
    func makeBody(configuration: Configuration, user: UserModel, storyIndex: Int, message: Binding<String>, focused: FocusState<Bool>.Binding) -> some View {
        return _makeBody(configuration, user, storyIndex, message, focused)
    }
}

// MARK: - DefaultMessageStyle
/// The default message field style.
///
/// Use the ``MessageStyle/automatic`` to apply this style.
///
/// ```swift
/// SSStoryStatus(users: users)
///     .messageStyle(.automatic)
/// ```
public struct DefaultMessageStyle: MessageStyle {

    // MARK: - Vars & Lets
    /// The font that is used for message text.
    var messageFont: Font?
    
    /// The color for the message text.
    var messageColor: Color
    
    // MARK: - Body
    /// Creates a view that represents the body of a message field.
    ///
    /// The default implementation for ``MessageStyle`` is implemented by default.
    /// The system calls this method for each message field when required.
    ///
    /// - Parameters:
    ///   - configuration: The properties of message field.
    ///   - message: The message binding for text field.
    ///   - focused: The focus state for text field.
    /// - Returns: A view containing message field appearance and behaviour.
    @ViewBuilder
    public func makeBody(configuration: Configuration, user: UserModel, storyIndex: Int, @Binding message: String, focused: FocusState<Bool>.Binding) -> some View {
        HStack {
            TextField(
                text: $message,
                prompt: configuration.placeholder
            ) { }
                .focused(focused)
                .foregroundStyle(messageColor)
                .font(messageFont)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onSubmit {
                    configuration.onSend?(message, user, storyIndex)
                    message = ""
                }
                .padding(.vertical, Sizes.textFieldVPadding)
                .padding(.horizontal, Sizes.textFieldHPadding)
            
            Button {
                configuration.onSend?(message, user, storyIndex)
                message = ""
                focused.wrappedValue = false
            } label: {
                configuration.sendIcon
                    .padding(.vertical, Sizes.textFieldVPadding)
                    .padding(.horizontal, Sizes.textFieldHPadding)
                    .font(Fonts.messageFont)
            }
            .buttonStyle(.plain)
            .opacity(message.count > 0 ? 1 : 0)
            .animation(.easeInOut(duration: 0.1), value: message)
        }
        .overlay {
            RoundedRectangle(cornerRadius: Sizes.textFieldCornerRadius)
                .stroke(.white, lineWidth: Sizes.textFieldStrokeWidth)
                .contentShape(Rectangle())
                .allowsHitTesting(!focused.wrappedValue)
                .onTapGesture {
                    focused.wrappedValue = true
                }
        }
        .foregroundStyle(.white)
    }
}

// MARK: - Public Methods
extension DefaultMessageStyle {
    
    /// Sets the font for message text.
    ///
    /// - Parameter font: The font to set on message text.
    /// - Returns: A new style with given font.
    public func font(_ font: Font?) -> Self {
        var copy = self
        copy.messageFont = font
        return copy
    }
    
    
    /// Sets the color on message text.
    ///
    /// - Parameter color: The color to set on message text.
    /// - Returns: A new style with given text color.
    public func textColor(_ color: Color) -> Self {
        var copy = self
        copy.messageColor = color
        return copy
    }
}


// MARK: - MessageStyle extension for DefaultMessageStyle
extension MessageStyle where Self == DefaultMessageStyle {
    
    /// A default message field style containing default style appearance and behaviour.
    public static var automatic: DefaultMessageStyle { automatic() }
    
    /// A default message field style containing default style and accepts custom values.
    public static func automatic(
        messageFont: Font = Fonts.messageFont,
        messageColor: Color = .white
    ) -> DefaultMessageStyle {
        
        DefaultMessageStyle(
            messageFont: messageFont,
            messageColor: messageColor
        )
    }
}
