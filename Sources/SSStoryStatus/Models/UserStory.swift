//
//  UserStory.swift
//  
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

// MARK: - User Model
public struct UserModel: Identifiable, Hashable {
    public var id: String
    let name: String
    let image: String
    let stories: [StoryModel]
    
    public var isAllStoriesSeen: Bool {
        stories.allSatisfy { story in
            story.storyState == .seen
        }
    }
    
    public init(id: String = UUID().uuidString, name: String, image: String, stories: [StoryModel]) {
        self.id = id
        self.name = name
        self.image = image
        self.stories = stories
    }
}

// MARK: - Story Model
public struct StoryModel: Identifiable, Hashable {
    public var id: String
    let mediaURL: String
    let date: Date
    let information: String
    let duration: Float
    let mediaType: MediaType
    var storyState: StoryState
    
    public init(id: String = UUID().uuidString, mediaURL: String, date: Date, information: String, duration: Float = Durations.storyDefaultDuration, mediaType: MediaType, storyState: StoryState = .unseen) {
        self.id = id
        self.mediaURL = mediaURL
        self.date = date
        self.information = information
        self.duration = duration
        self.mediaType = mediaType
        self.storyState = storyState
    }
    
    // MARK: - StoryType
    public enum MediaType: Equatable {
        case image
        case video
    }

    // MARK: - StoryState
    public enum StoryState {
        case seen
        case unseen
    }
}
