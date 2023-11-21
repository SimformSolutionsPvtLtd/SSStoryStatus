//
//  StoryDetailView.swift
//
//
//  Created by Krunal Patel on 27/10/23.
//

import SwiftUI

struct StoryDetailView: View {
    
    @Environment(StoryViewModel.self) private var storyViewModel: StoryViewModel
    var user: UserModel
    @State private var currentStoryIndex = 0
    
    var body: some View {
        let story = getStory()
        
        GeometryReader { geo in
            VStack {
                StoryHeaderView(user: user)
                
                ZStack {
                    Color.black
                    
                    AsyncImage(url: URL(string: story.mediaURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .onTapGesture { location in
                    print(location)
                    if location.x < geo.size.width / 2 {
                        print("left")
                        previousStory()
                    } else {
                        print("right")
                        nextStory()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Private Methods
extension StoryDetailView {
    
    private func getStory() -> StoryModel {
        user.stories[currentStoryIndex]
    }
    
    private func changeStory(direction: StoryDirection = .next) {
        switch direction {
        case .next:
            break
        case .previous:
            break
        }
    }
    
    private func nextStory() {
        guard currentStoryIndex < user.stories.count - 1 else {
            storyViewModel.nextUser()
            return
        }
        currentStoryIndex += 1
    }
    
    private func previousStory() {
        guard currentStoryIndex > 0 else {
            storyViewModel.previousUser()
            return
        }
        currentStoryIndex -= 1
    }
}

#Preview {
    StoryDetailView(user: mockData[0])
}
