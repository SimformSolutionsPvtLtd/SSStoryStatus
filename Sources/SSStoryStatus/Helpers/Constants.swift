//
//  Constants.swift
//  
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

// MARK: - Sizes
enum Sizes {
    // MARK: Profile
    static let profileImageWidth: CGFloat = 80
    static let profileImageHeight: CGFloat = 80
    static let profileImageSmallWidth: CGFloat = 40
    static let profileImageSmallHeight: CGFloat = 40
    static let profileVStackSpace: CGFloat = 6
    static let profileViewSpace: CGFloat = 12
    static let profileStrokeSpace: CGFloat = 6
    static let profileStrokeWidth: CGFloat = 3
    static let profileUsernameSize: CGFloat = 16
    
    // MARK: Story
    static let storyProgressBarHeight: CGFloat = 3
    static let progressBarSpacing: CGFloat = 5
    static let storyUserHStackSpace: CGFloat = 13
    static let storySpaceUserImage: CGFloat = 30
    static let storyGestureHeight: CGFloat = 50
    static let storyGestureWidth: CGFloat = 100
    static let storyProgressSpace: CGFloat = 8
}

// MARK: - Custom Colors
enum Colors {
    static let lightGreen = Color("LightGreen", bundle: .module)
    static let lightGray = Color("LightGray", bundle: .module)
}

// MARK: - Images
enum Images {
    static let closeMark = "xmark"
    static let placeholderImage = "photo.circle.fill"
    static let placeholderProfile = "person.crop.circle"
    static let error = "ant.circle.fill"
}

// MARK: - Durations
public enum Durations {
    public static let storyDefaultDuration: Int = 10
}
