//
//  ProgressBarStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

public struct ProgressBarStyle {
    
    // MARK: - Vars & Lets
    var foreground: AnyShapeStyle
    var background: AnyShapeStyle
    var height: CGFloat
    
    // MARK: - Initializer
    public init<S1: ShapeStyle, S2: ShapeStyle>(foreground: S1 = .white, background: S2 = .gray.opacity(0.5), height: CGFloat = Sizes.progressBarHeight) {
        self.foreground = AnyShapeStyle(foreground)
        self.background = AnyShapeStyle(background)
        self.height = height
    }
}

// MARK: - Public Methods
extension ProgressBarStyle {
    
    public func foreground<S: ShapeStyle>(_ style: S) -> Self {
        var copy = self
        copy.foreground = AnyShapeStyle(style)
        return self
    }
    
    public func background<S: ShapeStyle>(_ style: S) -> Self {
        var copy = self
        copy.background = AnyShapeStyle(style)
        return self
    }
    
    public func height(_ height: CGFloat) -> Self {
        var copy = self
        copy.height = height
        return copy
    }
}
