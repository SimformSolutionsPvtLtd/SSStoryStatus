//
//  ContentView.swift
//  SSStoryStatusDemo
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI
import SSStoryStatus

struct ContentView: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            SSStoryStatus(users: MockData().data)
                .changeImageCache(cache: .storage)
                .profileListStyle(
                    .automatic
                        .horizontalSpacing(24)
                )
                .profileStyle(
                    .automatic
                        .profileSize(width: 80, height: 80)
                        .strokeStyles(seen: .gray, unseen: .linearGradient(colors: [.green, .orange], startPoint: .top, endPoint: .bottom))
                )
                .storyStyle(
                    progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing))
                )
                .onStorySeen { user, storyIndex in
                    print("Seen", user.name, user.stories[storyIndex].mediaURL)
                }
                .emoji(["🪄", "🧙🏼‍♂️", "🔮", "🧚", "🦉"]) { emoji, user, storyIndex  in
                    print("Story", user.name, user.stories[storyIndex].mediaURL)
                    print("Select - ", emoji)
                }
                .messageField { message, user, storyIndex in
                    print("Story", user.name, user.stories[storyIndex].mediaURL)
                    print("Send - ", message)
                }
                
            Spacer()
        }
    }
}
