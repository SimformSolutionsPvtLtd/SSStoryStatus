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
    @Environment(\.storySeenAction) private var onStorySeen
    @GestureState private var isPressing = false
    @State var userViewModel = UserViewModel()
    var currentUser: UserModel
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                Group {
                    StoryProgressView()
                    
                    StoryHeaderView(user: currentUser, story: currentUser.stories[userViewModel.currentStoryIndex], dismiss: dismiss)
                }
                .opacity(userViewModel.isPaused ? 0 : 1)
                .animation(.easeInOut(duration: 0.5), value: userViewModel.isPaused)
                
                ZStack {
                    Color.black
                    
                    storyMediaView
                }
                .onTapGesture { location in
                    handleTapGesture(location: location, geo: geo)
                }
                .gesture(longPressGesture)
                .onChange(of: isPressing) { _, newValue in
                    handleLongPress(isPressed: newValue)
                }
                .onChange(of: userViewModel.currentStoryUserState) { _, newState in
                    handleUserChange(for: newState)
                }
                .onChange(of: userViewModel.currentStoryIndex) { oldValue, _ in
                    handleStorySeen(user: currentUser, storyIndex: oldValue)
                }
                .onChange(of: storyViewModel.currentUser) { oldValue, _ in
                    if currentUser == oldValue {
                        handleStorySeen(user: oldValue, storyIndex: userViewModel.currentStoryIndex)
                    }
                }
                .onChange(of: storyViewModel.isStoryPresented) { _, isPresented in
                    if !isPresented {
                        handleStorySeen(user: currentUser, storyIndex: userViewModel.currentStoryIndex)
                    }
                }
                .onAppear {
                    userViewModel.updateUser(user: currentUser)
                    userViewModel.updateProgressState(isPaused: false)
                }
            }
            .rotation3DEffect(
                getAngle(geo: geo),
                axis: (x: 0, y: 1, z: 0),
                anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing,
                perspective: 2.5)
            .environment(userViewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Private Views
    @ViewBuilder
    private var storyMediaView: some View {
        let story = currentUser.stories[userViewModel.currentStoryIndex]
        
        switch story.mediaType {
        case .image:
            getStoryImageView(story: story)
        case .video:
            getStoryVideoView(story: story)
        }
    }
    
    @ViewBuilder
    private func getStoryImageView(story: StoryModel) -> some View {
        CachedAsyncImage(imageModel: userViewModel.imageModel) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                Image(systemName: Images.error)
                    .onAppear {
                        userViewModel.changeStory()
                    }
            default:
                ProgressView()
            }
        }
        .onChange(of: userViewModel.currentStoryIndex, initial: true) {
            userViewModel.imageModel.getImage(url: URL(string: story.mediaURL))
        }
    }
    
    @ViewBuilder
    private func getStoryVideoView(story: StoryModel) -> some View {
        
        CachedAsyncVideo(id: story.id, url: URL(string: story.mediaURL), isPaused: userViewModel.isPaused) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let player):
                player
                    .disabled(true)
            case .failure(_):
                Image(systemName: Images.error)
            }
        }
        .onProgressChange(perform: updateStoryProgress)
    }
}

// MARK: - Private Methods
extension StoryDetailView {
    
    private func handleTapGesture(location: CGPoint, geo: GeometryProxy) {
        if location.x < geo.size.width / 2 {
            userViewModel.changeStory(direction: .previous)
        } else {
            userViewModel.changeStory()
        }
    }
    
    private func handleLongPress(isPressed: Bool) {
        userViewModel.updateProgressState(isPaused: isPressed)
    }
    
    private func updateStoryProgress(progress: Double, totalDuration: Double) {
        userViewModel.updateCurrentProgress(progress: Float(progress), totalDuration: Float(totalDuration))
    }
    
    private func handleUserChange(for state: UserViewModel.CurrentStoryUserState) {
        switch state {
        case .next:
            storyViewModel.nextUser()
        case .previous:
            storyViewModel.previousUser()
        case.current:
            break
        }
    }
    
    private func getAngle(geo: GeometryProxy) -> Angle {
        
        // Converting offset to 45° rotation
        let progress = geo.frame(in: .global).minX / geo.size.width
        let rotationAngle: CGFloat = 45
        let degree = progress * rotationAngle
        return Angle(degrees: degree)
    }
    
    private func handleStorySeen(user: UserModel, storyIndex: Int) {
        storyViewModel.storySeen(user: user, storyIndex: storyIndex)
        onStorySeen?(user, storyIndex)
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
