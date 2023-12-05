//
//  Environment.swift
//
//
//  Created by Krunal Patel on 03/11/23.
//

import SwiftUI

// MARK: - Story Seen Action Key
struct StorySeenActionKey: EnvironmentKey {
    
    static var defaultValue: StorySeenAction?
}

// MARK: - Action Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var storySeenAction: StorySeenAction? {
        get { self[StorySeenActionKey.self] }
        set { self[StorySeenActionKey.self] = newValue }
    }
}
