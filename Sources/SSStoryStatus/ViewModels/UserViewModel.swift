//
//  UserViewModel.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 02/11/23.
//

import SwiftUI
import Observation
import Combine

@Observable
class UserViewModel {
    
    // MARK: - Vars & Lets
    var user: UserModel
    var currentStoryIndex: Int!
    var currentStoryUserState: CurrentStoryUserState = .current
    var imageModel = AsyncImageModel()
    var videoModel = AsyncVideoModel()
    var progressModels: [StoryProgressModel] = []
    var storyDuration: Float = Durations.storyDefaultDuration
    private (set) var isPaused = true
    private var timer: Timer.TimerPublisher?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Methods
    func changeStory(direction: StoryDirection = .next) {
        videoModel.resetPlayer()
        switch direction {
        case .next:
            nextStory()
        case .previous:
            previousStory()
        }
    }
    
    func updateUser(user: UserModel) {
        progressModels = user.stories.map { story in
            StoryProgressModel(id: story.id, totalDuration: storyDuration)
        }
        updateCurrentStoryIndex(for: user)
        currentStoryUserState = .current
    }
    
    func updateProgressState(isPaused: Bool) {
        self.isPaused = isPaused
        guard user.stories[currentStoryIndex].mediaType != .video else {
            stopTimer()
            return
        }
        
        if isPaused {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    func updateCurrentProgress(progress: Float, totalDuration: Float) {
        let progressModel = progressModels[currentStoryIndex]
        
        guard progressModel.canProgress() || totalDuration == 0 else {
            changeStory()
            return
        }
        progressModel.increaseProgress(by: Float(Durations.videoProgressUpdateInterval))
        progressModels[currentStoryIndex].totalDuration = totalDuration
    }
    
    func observeTimer() {
        timer?.sink { [weak self] _ in
            self?.increaseProgress()
        }
        .store(in: &cancellables)
    }
    
    func reset() {
        stopTimer()
        videoModel.resetPlayer()
        progressModels[currentStoryIndex].resetProgress()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: Durations.progressUpdateInterval, on: .main, in: .common)
        timer?.connect().store(in: &cancellables)
        observeTimer()
    }
    
    private func updateCurrentStoryIndex(for user: UserModel) {
        if user.isAllStoriesSeen {
            currentStoryIndex = 0
        } else {
            currentStoryIndex = user.seenStoriesCount
            progressModels[0..<currentStoryIndex].forEach { $0.completeProgress() }
        }
    }
    
    private func stopTimer() {
        cancellables.removeAll()
    }
    
    private func nextStory() {
        guard currentStoryIndex < user.stories.count - 1 else {
            currentStoryUserState = .next
            progressModels[currentStoryIndex].resetProgress()
            return
        }
        progressModels[currentStoryIndex].completeProgress()
        currentStoryIndex += 1
        progressModels[currentStoryIndex].resetProgress()
        updateProgressState(isPaused: false)
    }
    
    private func previousStory() {
        progressModels[currentStoryIndex].resetProgress()
        
        guard currentStoryIndex > 0 else {
            currentStoryUserState = .previous
            return
        }
        currentStoryIndex -= 1
        progressModels[currentStoryIndex].resetProgress()
        updateProgressState(isPaused: false)
    }
    
    private func increaseProgress() {
        let story = progressModels[currentStoryIndex]
        if  story.canProgress() {
            story.increaseProgress()
        } else {
            changeStory()
        }
    }
    
    // MARK: - Initializer
    init(user: UserModel) {
        self.user = user
        updateUser(user: user)
    }
}

// MARK: - Enums
extension UserViewModel {
    
    // MARK: - CurrentStoryUserSate
    enum CurrentStoryUserState {
        case previous
        case current
        case next
    }
}
