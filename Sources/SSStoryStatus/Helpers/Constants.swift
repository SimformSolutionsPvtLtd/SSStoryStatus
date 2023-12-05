//
//  Constants.swift
//  
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

// MARK: - Sizes
public enum Sizes {
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
    public static let minimumScaleFactor: CGFloat = 0.5
    static let fixedProgressPartitionSpacing: CGFloat = 8
    static let progressPartitionPercentage = 0.5
    
    // MARK: Story
    static let storyProgressBarHeight: CGFloat = 3
    static let progressBarSpacing: CGFloat = 6
    static let storyUserHStackSpace: CGFloat = 13
    static let closeButtonSize: CGFloat = 44
    static let closeButtonPadding: CGFloat = 14
    static let headerSpacing: CGFloat = 8
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
    public static let storyDefaultDuration: Float = 10
    static let progressUpdateInterval: TimeInterval = 0.1
    static let videoProgressUpdateInterval: TimeInterval = 0.5
    static let longPressDuration: Double = 0.5
}

// MARK: - Paths
enum Paths {
    static let cacheDirectoryName = "SSStoryDemo"
}

// MARK: - Fonts
enum Fonts {
    static let usernameFont: Font = .system(size: Sizes.profileUsernameSize, weight: .medium, design: .rounded)
    static let storyUsernameFont: Font = .system(size: Sizes.profileUsernameSize, weight: .medium, design: .rounded)
    static let storyDateFont: Font = .system(size: Sizes.profileUsernameSize, weight: .semibold, design: .rounded)
}

// MARK: - Angles
enum Angles {
    static let dashPhase: CGFloat = 60
    static let trimAngle: Angle = .degrees(-90)
}
