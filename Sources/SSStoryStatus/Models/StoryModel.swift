//
//  StoryModel.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 14/12/23.
//

import Foundation

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
    public init(id: String = UUID().uuidString, mediaURL: String, date: Date, caption: String = "", mediaType: MediaType, storyState: StoryState = .unseen) {
        self.id = id
        self.mediaURL = mediaURL
        self.date = date
        self.caption = caption
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
