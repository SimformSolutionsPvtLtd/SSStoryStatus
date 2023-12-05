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
public typealias MessageSendAction = (_ message: String, _ user: UserModel, _ storyIndex: Int) -> Void

// MARK: - Preview
#Preview {
    MessageTextField(user: mockData[0], storyIndex: 0)
}
