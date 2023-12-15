//
//  UserModel.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 14/12/23.
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
