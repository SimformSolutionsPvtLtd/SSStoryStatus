//
//  UserStory.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

// MARK: - User Model
@Observable
public class UserModel: Identifiable, Hashable {
    
    // MARK: - Vars & Lets
    public let id: String
    public let name: String
    public let image: String
    public let stories: [StoryModel]
    
    public var isAllStoriesSeen: Bool {
        stories.allSatisfy { story in
            story.storyState == .seen
        }
    }
    
    public var seenStoriesCount: Int {
        stories.filter { $0.storyState == .seen }.count
    }
    
    public static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Initializer
    public init(id: String = UUID().uuidString, name: String, image: String, stories: [StoryModel]) {
        self.id = id
        self.name = name
        self.image = image
        self.stories = stories
    }
}

// MARK: - Story Model
@Observable
public class StoryModel: Identifiable, Hashable {
    
    // MARK: - Vars & Lets
    public let id: String
    public let mediaURL: String
    public let date: Date
    public let caption: String
    public let duration: Float
    public let mediaType: MediaType
    public var storyState: StoryState
    
    public static func == (lhs: StoryModel, rhs: StoryModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Initializer
    public init(id: String = UUID().uuidString, mediaURL: String, date: Date, caption: String = "", duration: Float = Durations.storyDefaultDuration, mediaType: MediaType, storyState: StoryState = .unseen) {
        self.id = id
        self.mediaURL = mediaURL
        self.date = date
        self.caption = caption
        self.duration = duration
        self.mediaType = mediaType
        self.storyState = storyState
    }
}

// MARK: - StoryModel Enums
extension StoryModel {
    
    // MARK: - MediaType
    public enum MediaType {
        case image
        case video
    }

    // MARK: - StoryState
    public enum StoryState {
        case seen
        case unseen
    }
}
