//
//  swift
//
//
//  Created by Krunal Patel on 02/11/23.
//

import SwiftUI
import Observation
import Combine

@Observable
class UserViewModel {
    
    // MARK: - Vars & Lets
    var user: UserModel?
    var currentStoryUserState: CurrentStoryUserState = .current
    var imageModel = AsyncImageModel()
    var progressModels: [StoryProgressModel] = []
    var currentStoryIndex = 0
    private (set) var isPaused = false
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var cancallables: Set<AnyCancellable> = []
    
    // MARK: - Methods
    func changeStory(direction: StoryDirection = .next) {
        switch direction {
        case .next:
            nextStory()
        case .previous:
            previousStory()
        }
    }
    
    func updateUser(user: UserModel) {
        if self.user == nil {
            progressModels = user.stories.map { story in
                StoryProgressModel(id: story.id, totalDuration: story.duration)
            }
        } else {
            progressModels[currentStoryIndex].resetProgress()
        }
        self.user = user
        currentStoryUserState = .current
    }
    
    func updateProgressState(isPaused: Bool) {
        self.isPaused = isPaused
        guard let user = user, user.stories[currentStoryIndex].mediaType != .video else {
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
        .store(in: &cancallables)
    }
    
    private func startTimer() {
        timer = Timer.publish(every: Durations.progressUpdateInterval, on: .main, in: .common).autoconnect()
        observeTimer()
    }
    
    private func stopTimer() {
        timer?.upstream.connect().cancel()
    }
    
    private func nextStory() {
        guard let user, currentStoryIndex < user.stories.count - 1 else {
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
}

extension UserViewModel {
    
    // MARK: - Current Story User Sate
    enum CurrentStoryUserState {
        case previous
        case current
        case next
    }
}

@Observable
class StoryProgressModel: Identifiable {
    
    @ObservationIgnored let id: String
    var totalDuration: Float
    var progress: Float = 0
    
    init(id: String, totalDuration: Float) {
        self.id = id
        self.totalDuration = totalDuration
    }
    
    func increaseProgress(by duration: Float = Float(Durations.progressUpdateInterval)) {
        withAnimation(.linear(duration: TimeInterval(duration))) {
            progress = (progress + duration).clamped(to: 0...totalDuration)
        }
    }
    
    func completeProgress() {
        progress = totalDuration
    }
    
    func resetProgress() {
        progress = 0
    }
    
    func canProgress() -> Bool {
        return Int(progress) < Int(totalDuration)
    }
}
