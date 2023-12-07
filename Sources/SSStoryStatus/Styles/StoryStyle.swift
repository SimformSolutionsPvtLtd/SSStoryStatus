//
//  StoryStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 08/12/23.
//

/// A style that is applied on story view.
///
/// Set the style by passing instance of `Style` to
/// ``SwiftUI/View/storyStyle(_:headerStyle:footerStyle:progressBarStyle:)``.
///
/// You can customize the default values with the use of available method or
/// create new instance with custom value using ````.
///
/// For example set gradient for progress foreground,
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing)))
/// ```
///
public struct StoryStyle {
    
    /// The preferred spacing between progress bars in percentage.
    public var storyDuration: Float
    
    // MARK: - Initializer
    /// Use this initializer to create instance of `ProgressBarStyle` with custom values.
    ///
    /// - Parameter storyDuration: The duration for image stories.
    public init(storyDuration: Float = Durations.storyDefaultDuration) {
        self.storyDuration = storyDuration
    }
}

// MARK: - Public Methods   
extension StoryStyle {    
    
    /// Sets the duration for image stories.
    /// - Parameter duration: The new duration to set.
    /// - Returns: A new style with new image duration.
    public func storyDuration(_ duration: Float) -> Self {
        var copy = self
        copy.storyDuration = duration
        return copy
    }
}
