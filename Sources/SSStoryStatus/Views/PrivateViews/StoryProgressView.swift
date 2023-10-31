//
//  StoryProgressView.swift
//
//
//  Created by Krunal Patel on 30/10/23.
//

import SwiftUI

struct StoryProgressView: View {
    
    // MARK: - Vars & Lets
    @Environment(StoryViewModel.self) private var storyViewModel
    @State private var timer = Timer.publish(every: Durations.progressUpdateInterval, on: .main, in: .common).autoconnect()
    
    // MARK: - Body
    var body: some View {
        
        HStack(spacing: Sizes.progressBarSpacing) {
            
            ForEach(storyViewModel.storyProgressModels) { story in
                ProgressView(value: story.progress, total: story.totalDuration)
                    .tint(.white)
                    .progressViewStyle(.linear)
            }
        }
        .onReceive(timer) { _ in
            increaseProgress()
        }
        .onChange(of: storyViewModel.currentStoryIndex, handleStoryChange)
        .onChange(of: storyViewModel.isProgressPaused) { _, newValue in
            handleTimer(isPaused: newValue)
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
}

// MARK: - Private Methods
extension StoryProgressView {
    
    private func increaseProgress() {
        let story = storyViewModel.storyProgressModels[storyViewModel.currentStoryIndex]
        if  story.canProgress() {
            story.increaseProgress()
        } else {
            nextStory()
        }
    }
    
    private func handleStoryChange(oldIndex: Int, newIndex: Int) {
        // User is changed, no need to change progress
        guard oldIndex < storyViewModel.storyProgressModels.count else {
            return
        }
        
        if newIndex > oldIndex {
            storyViewModel.storyProgressModels[oldIndex].completeProgress()
        } else {
            storyViewModel.storyProgressModels[oldIndex].resetProgress()
        }
        storyViewModel.storyProgressModels[newIndex].resetProgress()
    }
    
    private func handleTimer(isPaused: Bool) {
        if isPaused {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.publish(every: Durations.progressUpdateInterval, on: .main, in: .common).autoconnect()
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    private func nextStory() {
        storyViewModel.nextStory()
    }
}

// MARK: - Preview
#Preview {
    StoryProgressView()
}
