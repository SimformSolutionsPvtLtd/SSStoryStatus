//
//  UserStory.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

// MARK: - User Model
/// The user model containing information related to user.
@Observable
public class UserModel: Identifiable, Hashable {
    
    // MARK: - Vars & Lets
    /// The unique identifier for user.
    public let id: String
    
    /// The user name of user.
    public let name: String
    
    /// The profile image url.
    public let image: String
    
    /// The list of ``StoryModel`` containing information related 
    /// to user.
    public let stories: [StoryModel]
    
    /// A boolean value that represent whether the all stories is seen or not.
    public var isAllStoriesSeen: Bool {
        stories.allSatisfy { story in
            story.storyState == .seen
        }
    }
    
    // The count for seen stories of user.
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
/// The story model containing all necessary information related to story.
@Observable
public class StoryModel: Identifiable, Hashable {
    
    // MARK: - Vars & Lets
    /// The unique identifier for story,
    public let id: String
    
    /// The media url of story.
    public let mediaURL: String
    
    /// The story creation date.
    public let date: Date
    
    /// The caption for the story.
    public let caption: String
    
    /// The duration for the story in seconds.
    public let duration: Float
    
    /// The type of media.
    public let mediaType: MediaType
    
    /// The current story state.
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
    /// The type of media.
    public enum MediaType {
        
        /// The image media type.
        case image

        /// The video media type.
        case video
    }

    // MARK: - StoryState
    /// The type of story status.
    public enum StoryState {
        
        /// Seen story type.
        case seen
        
        /// Unseen story type.
        case unseen
    }
}
