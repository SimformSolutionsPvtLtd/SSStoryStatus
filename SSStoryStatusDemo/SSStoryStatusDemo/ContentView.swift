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
            SSStoryStatus(users: SSStoryStatusDemo.mockData)
                .profileListStyle(.default
                    .profileSize(width: 80, height: 80)
                    .font(.system(size: 18))
                )
                .storyStyle(
                    .default
                        .dismissImage(Image(systemName: "square.and.arrow.up"))
                        .dismissColor(.red)
                )
                .onStorySeen { user, storyIndex in
                    print("Seen", user.name, user.stories[storyIndex].mediaURL)
                }
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
