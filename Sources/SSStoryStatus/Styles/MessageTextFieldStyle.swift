//
//  RoundedTextFieldStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

public struct MessageStyleConfiguration {
    
    // MARK: - Vars & Lets
    var placeholder: Text = Text(Strings.messagePlaceholder)
        .font(Fonts.messagePlaceholderFont)
        .foregroundStyle(Colors.placeholderColor)
    var sendIcon: Image = Image(systemName: Images.messageSend)
    var onSend: MessageSendAction?
}

public protocol MessageStyle {
    
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration, user: UserModel, storyIndex: Int, message: Binding<String>, focused: FocusState<Bool>.Binding) -> Self.Body
    
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
public struct DefaultMessageStyle: MessageStyle {

    // MARK: - Vars & Lets
    var messageFont: Font?
    var messageColor: Color
    
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
    
    public func font(_ font: Font?) -> Self {
        var copy = self
        copy.messageFont = font
        return copy
    }
    
    public func textColor(_ color: Color) -> Self {
        var copy = self
        copy.messageColor = color
        return copy
    }
}


// MARK: - MessageStyle extension for DefaultMessageStyle
extension MessageStyle where Self == DefaultMessageStyle {
    
    public static var automatic: DefaultMessageStyle { automatic() }
    
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
