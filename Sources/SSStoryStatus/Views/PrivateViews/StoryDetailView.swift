//
//  StoryDetailView.swift
//  SSStoryStatus
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
    @State private var userViewModel = UserViewModel()
    var currentUser: UserModel
    
    var currentStory: StoryModel {
        currentUser.stories[userViewModel.currentStoryIndex]
    }
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                Color.black
                
                storyMediaView
                    .ignoresSafeArea()
                    .scale(contentMode: storyViewModel.isZoomed ? .fill : .fit)
            }
            .overlay(alignment: .top) {
                    StoryHeaderView(user: currentUser, story: currentStory, dismiss: dismiss)
                        .opacity(userViewModel.isPaused ? 0 : 1)
                        .animation(.easeInOut(duration: 0.5), value: userViewModel.isPaused)
            }
            .onTapGesture { location in
                handleTapGesture(location: location, geo: geo)
            }
            .gesture(longPressGesture)
            .gesture(magnificationGesture)
            .overlay(alignment: .bottom) {
                StoryFooterView(user: currentUser, storyIndex: userViewModel.currentStoryIndex)
            }
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
                if let oldValue, currentUser == oldValue {
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
            .onDisappear {
                userViewModel.reset()
            }
            .rotation3DEffect(
                getAngle(geo: geo),
                axis: (x: 0, y: 1, z: 0),
                anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing,
                perspective: 2.5)
        }
        .environment(userViewModel)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Private Views
extension StoryDetailView {
    
    @ViewBuilder
    private var storyMediaView: some View {
        switch currentStory.mediaType {
        case .image:
            getStoryImageView(story: currentStory)
        case .video:
            getStoryVideoView(story: currentStory)
        }
    }
    
    @ViewBuilder
    private func getStoryImageView(story: StoryModel) -> some View {
        CachedAsyncImage(imageModel: userViewModel.imageModel) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
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
            userViewModel.imageModel.getImage(url: URL(string: story.mediaURL), type: .story(story.date))
        }
    }
    
    @ViewBuilder
    private func getStoryVideoView(story: StoryModel) -> some View {
        CachedAsyncVideo(videoModel: userViewModel.videoModel, isPaused: userViewModel.isPaused) { phase in
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
        .task(id: storyViewModel.currentUser) {
            if currentUser == storyViewModel.currentUser {
                await userViewModel.videoModel.fetchVideo(url: URL(string: story.mediaURL), date: story.date)
            }
        }
    }
}

// MARK: - Methods
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
    
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged{ value in
                if value < 0.8 {
                    storyViewModel.isZoomed = false
                } else if value > 1.3 {
                    storyViewModel.isZoomed = true
                }
            }
    }

    // To get touch down and touch up event during long press,
    // we have to user another `LongPressGesture` with infinity duration
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

// MARK: - Typealias
public typealias StorySeenAction = (_ user: UserModel, _ storyIndex: Int) -> Void

// MARK: - Preview
#Preview {
    StoryDetailView(currentUser: mockData[0])
}

