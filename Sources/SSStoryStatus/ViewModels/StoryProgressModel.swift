//
//  StoryProgressModel.swift
//
//
//  Created by Krunal Patel on 17/11/23.
//

import SwiftUI
import Observation

@Observable
class StoryProgressModel: Identifiable {
    
    // MARK: - Vars & Lets
    @ObservationIgnored let id: String
    var totalDuration: Float
    var progress: Float = 0
    
    // MARK: - Methods
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
    
    // MARK: - Initializer
    init(id: String, totalDuration: Float) {
        self.id = id
        self.totalDuration = totalDuration
    }
}
