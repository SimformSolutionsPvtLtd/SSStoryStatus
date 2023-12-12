//
//  ProgressBarStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

/// A style that is applied on progress bar of story view.
///
/// Set the style by passing instance of `ProgressBarStyle` to
/// ``SwiftUI/View/storyStyle(_:headerStyle:footerStyle:progressBarStyle:)``.
///
/// You can customize the default values with the use of available method or
/// create new instance with custom value using ``init(foreground:background:height:)``.
///
/// For example set gradient for progress foreground,
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing)))
/// ```
///
public struct ProgressBarStyle {
    
    // MARK: - Vars & Lets
    /// The foreground shape style indicating progress.
    public var foreground: AnyShapeStyle
    
    /// The background shape style for background of progress bar.
    public var background: AnyShapeStyle
    
    /// The height of progress bar.
    public var height: CGFloat
    
    /// The preferred spacing between progress bars in percentage.
    public var preferredSpacingPercentage: CGFloat = Sizes.progressBarSpacingPercentage
    
    /// The bound for min and max spacing between progress bars.
    public var spacingBound: ClosedRange<CGFloat> = Sizes.progressBarSpacingBound
    
    // MARK: - Initializer
    /// Use this initializer to create instance of `ProgressBarStyle` with custom values.
    ///
    /// You can use this initializer to create new instance of `ProgressBarStyle`.
    /// Alternatively you can also use the available methods to modify individual fields.
    ///
    /// - Parameters:
    ///   - foreground: The foreground for progress in progress bar.
    ///   - background: The background for the progress bar.
    ///   - height: The height of progress bar.
    public init<S1: ShapeStyle, S2: ShapeStyle>(foreground: S1 = .white, background: S2 = .gray.opacity(0.5), height: CGFloat = Sizes.progressBarHeight) {
        self.foreground = AnyShapeStyle(foreground)
        self.background = AnyShapeStyle(background)
        self.height = height
    }
}

// MARK: - Public Methods
extension ProgressBarStyle {
    
    /// Sets the foreground shape style for progress in progress bar.
    ///
    /// - Parameter style: The shape style for progress.
    /// - Returns: A style with new foreground style.
    public func foreground<S: ShapeStyle>(_ style: S) -> Self {
        var copy = self
        copy.foreground = AnyShapeStyle(style)
        return self
    }
    
    /// Sets the background shape style in progress bar.
    ///
    /// - Parameter style: The shape style for background.
    /// - Returns: A style with new background style.
    public func background<S: ShapeStyle>(_ style: S) -> Self {
        var copy = self
        copy.background = AnyShapeStyle(style)
        return self
    }
    
    /// Sets the height of progress bar.
    /// - Parameter height: The new height for progress bar.
    /// - Returns: A new style with given height of progress bar.
    public func height(_ height: CGFloat) -> Self {
        var copy = self
        copy.height = height
        return copy
    }
    
    /// Sets the preferred spacing percentage between progress bars.
    /// - Parameter percentage: The new percentage for spacing.
    /// - Returns: A new style with given spacing.
    public func preferredSpacePercentage(_ percentage: CGFloat) -> Self {
        var copy = self
        copy.preferredSpacingPercentage = percentage
        return copy
    }
    
    /// Sets the bound of spacing percentage between progress bars.
    /// - Parameter range: The new range for progress bar spacing.
    /// - Returns: A new style with given spacing bound.
    public func spacingBound(in range: ClosedRange<CGFloat>) -> Self {
        var copy = self
        copy.spacingBound = range
        return copy
    }
}
