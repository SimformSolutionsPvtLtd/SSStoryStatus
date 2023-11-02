//
//  StyleEnvironment.swift
//  
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileStyle Key
struct ProfileStyleEnvironment: EnvironmentKey {
    
    static var defaultValue: ProfileListStyle = .default
}

// MARK: - ProfileStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var profileStyle: ProfileListStyle {
        get { self[ProfileStyleEnvironment.self] }
        set { self[ProfileStyleEnvironment.self] = newValue }
    }
}

// MARK: - StoryStyle Key
struct StoryStyleEnvironment: EnvironmentKey {
    
    static var defaultValue: StoryStyle = .default
}

// MARK: - StoryStyle Keys EnvironmentValues Extension
extension EnvironmentValues {
    
    var storyStyle: StoryStyle {
        get { self[StoryStyleEnvironment.self] }
        set { self[StoryStyleEnvironment.self] = newValue }
    }
}

