//
//  MessageTextField.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 09/11/23.
//

import SwiftUI

struct MessageTextField: View {
    
    // MARK: - Vars & Lets
    @Environment(\.messageStyleConfiguration) var configuration
    @Environment(\.messageStyle) var style
    var focused: FocusState<Bool>.Binding?
    let user: UserModel
    let storyIndex: Int
    @FocusState var defaultFocused: Bool
    @State var message = ""
    
    // MARK: - Body
    var body: some View {
        style.makeBody(configuration: configuration,
                       user: user,
                       storyIndex: storyIndex,
                       message: $message,
                       focused: focused ?? $defaultFocused)
    }
}

// MARK: - Methods
extension MessageTextField {
    
    func focused(_ condition: FocusState<Bool>.Binding) -> Self {
        var copy = self
        copy.focused = condition
        return copy
    }
}


// MARK: - Typealias
/// A closure that is called when message is send.
///
/// - Parameters:
///   - message: The text message send by.
///   - user: The user containing story.
///   - storyIndex: The index of story.
public typealias MessageSendAction = (_ message: String, _ user: UserModel, _ storyIndex: Int) -> Void
