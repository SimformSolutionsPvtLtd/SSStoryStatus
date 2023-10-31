//
//  StoryViewModel.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI
import Observation

@Observable
class StoryViewModel {
    
    // MARK: - Vars & Lets
    @ObservationIgnored var userList: [UserModel]
    var currentUser: UserModel {
        didSet {
            updateProgresModel()
        }
    }
    var isStoryPresented = false
    var currentStoryIndex: Int = 0
    var isProgressPaused = false
    var storyProgressModels: [StoryProgressModel] = []
    
    // MARK: - Methods
    func viewStory(of user: UserModel) {
        currentUser = user
        isStoryPresented = true
    }
    
    func getStory() -> StoryModel {
        currentUser.stories[currentStoryIndex]
    }
    
    func nextStory() {
        guard currentStoryIndex < currentUser.stories.count - 1 else {
            nextUser()
            return
        }
        currentStoryIndex += 1
    }
    
    func previousStory() {
        guard currentStoryIndex > 0 else {
            previousUser()
            return
        }
        currentStoryIndex -= 1
    }
    
    func nextUser() {
        guard let index = getCurrentUserIndex(),
              index + 1 < userList.count else {
            isStoryPresented = false
            return
        }
        currentUser = userList[index + 1]
    }
    
    func previousUser() {
        guard let index = getCurrentUserIndex(),
              index > 0 else {
            isStoryPresented = false
            return
        }
        currentUser = userList[index - 1]
    }
    
    private func updateProgresModel() {
        currentStoryIndex = 0
        storyProgressModels = currentUser.stories.map { story in
            StoryProgressModel(id: story.id, totalDuration: story.duration)
        }
    }
    
    private func getCurrentUserIndex() -> Int? {
        guard let index = userList.firstIndex(where: { $0.id == currentUser.id }) else {
            return nil
        }
        return index
    }
    
    // MARK: - Initializer
    init(userList: [UserModel]) {
        self.userList = userList
        self.currentUser = userList[0]
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
        return progress < totalDuration
    }
}
