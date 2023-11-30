//
//  StoryDetailView.swift
//
//
//  Created by Krunal Patel on 27/10/23.
//

import SwiftUI

struct StoryDetailView: View {
    
    // MARK: - Vars & Lets
    @Environment(StoryViewModel.self) private var storyViewModel
    @Environment(\.dismiss) private var dismiss
    @GestureState private var isPressing = false
    @State var imageModel = AsyncImageModel()
    var currentUser: UserModel
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                Group {
                    StoryProgressView()
                    
                    StoryHeaderView(user: currentUser, dismiss: dismiss)
                }
                .opacity(storyViewModel.isProgressPaused ? 0 : 1)
                .animation(.easeInOut(duration: 0.5), value: storyViewModel.isProgressPaused)
                
                ZStack {
                    Color.black
                    
                    storyMediaView
                }
                .onTapGesture { location in
                    handleTapGesture(location: location, geo: geo)
                }
                .gesture(longPressGesture)
                .onChange(of: isPressing, { _, newValue in
                    handleLongPress(isPressed: newValue)
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Private Views
    @ViewBuilder
    private var storyMediaView: some View {
        let story = storyViewModel.getStory()
        
        switch story.mediaType {
        case .image:
            getStoryImageView(story: story)
        case .video:
            getStoryVideoView(story: story)
        }
    }
    
    @ViewBuilder
    private func getStoryImageView(story: StoryModel) -> some View {
        CachedAsyncImage(imageModel: imageModel) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                Image(systemName: Images.error)
                    .onAppear {
                        changeStory()
                    }
            default:
                ProgressView()
            }
        }
        .onChange(of: storyViewModel.currentStoryIndex, initial: true) {
            imageModel.getImage(url: URL(string: story.mediaURL))
        }
    }
    
    @ViewBuilder
    private func getStoryVideoView(story: StoryModel) -> some View {
        @Bindable var storyViewModel = storyViewModel
        
        CachedAsyncVideo(id: story.id, url: URL(string: story.mediaURL), isPaused: $storyViewModel.isProgressPaused) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let player):
                player
            case .failure(_):
                Image(systemName: Images.error)
            }
        }
        .onProgressChange(perform: updateStoryProgress)
    }
}

// MARK: - Private Methods
extension StoryDetailView {
    
    private func changeStory(direction: StoryDirection = .next) {
        switch direction {
        case .next:
            storyViewModel.nextStory()
        case .previous:
            storyViewModel.previousStory()
        }
    }
    
    private func handleTapGesture(location: CGPoint, geo: GeometryProxy) {
        if location.x < geo.size.width / 2 {
            changeStory(direction: .previous)
        } else {
            changeStory()
        }
    }
    
    private func handleLongPress(isPressed: Bool) {
        storyViewModel.isProgressPaused = isPressed
    }
    
    private func updateStoryProgress(progress: Double, totalDuration: Double) {
        storyViewModel.updateCurrentProgress(progress: Float(progress), totalDuration: Float(totalDuration))
    }
}

// MARK: - Gestures
extension StoryDetailView {
    
    // To get touch down and touch up event during long press, we have to user another `LongPressGesture` with infinity duration
    private var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: Durations.longPressDuration)
            .sequenced(before: LongPressGesture(minimumDuration: .infinity))
            .updating($isPressing) { value, state, transaction in
                if value == .second(true, nil) {
                    state = true
                }
            }
    }
}

// MARK: - Preview
#Preview {
    StoryDetailView(currentUser: mockData[0])
}
