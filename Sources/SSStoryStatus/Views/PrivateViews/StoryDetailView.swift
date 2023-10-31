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
                    
                    storyImageView
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
    private var storyImageView: some View {
        AsyncImage(url: URL(string: storyViewModel.getStory().mediaURL)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
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