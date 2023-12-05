//
//  StoryReactionView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 08/11/23.
//

import SwiftUI

struct StoryReactionView: View {
    
    // MARK: - Vars & Lets
    @Environment(UserViewModel.self) private var userViewModel
    @FocusState.Binding var focused: Bool
    let user: UserModel
    let storyIndex: Int
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            if focused {
                Spacer()
                
                EmojiView(user: user, storyIndex: storyIndex) { _, _, _ in
                    focused = false
                }
                .transition(.slide)
                .animation(.spring(), value: focused)
                
                Spacer()
            }
            
            MessageTextField(user: user, storyIndex: storyIndex)
                .focused($focused)
                .onChange(of: focused) { oldValue, isFocused in
                    userViewModel.updateProgressState(isPaused: isFocused)
                }
                .onChange(of: userViewModel.currentStoryUserState) { _, state in
                    if state != .current {
                        focused = false
                    }
                }
        }
        .padding(20)
        .background(
            Color.black.opacity(focused ? 0.8 : 0)
                .onTapGesture {
                    focused = false
                }
        )
    }
}
