//
//  ProfileListStyle.swift
//
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileListStyle
public protocol ProfileListStyle {
    
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    
    var strokeWidth: CGFloat { get set }
    var strokeColors: (seen: Color, unseen: Color) { get set }
    
    var hSpacing: CGFloat { get set }
    var vSpacing: CGFloat { get set }
    
    var font: Font { get set }
    var minimumScaleFactor: CGFloat { get set }
    var textColor: Color { get set }
}

// MARK: - Public Methods
extension ProfileListStyle {
    
    // MARK: - Sizes
    public func profileSize(width: CGFloat, height: CGFloat) -> Self {
        var copy = self
        copy.width = width
        copy.height = height
        return copy
    }
    
    public func strokeWidth(_ width: CGFloat) -> Self {
        var copy = self
        copy.strokeWidth = width
        return copy
    }
    
    // MARK: - Colors
    public func strokeColor(seen: Color, unseen: Color) -> Self {
        var copy = self
        copy.strokeColors = (seen, unseen)
        return copy
    }
    
    public func textColor(_ color: Color) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }
    
    // MARK: - Spaces
    public func imageUsernameSpacing(_ spacing: CGFloat) -> Self {
        var copy = self
        copy.vSpacing = spacing
        return copy
    }
    
    public func horizontalSpacing(_ spacing: CGFloat) -> Self {
        var copy = self
        copy.hSpacing = spacing
        return copy
    }
    
    // MARK: - Fonts
    public func font(_ font: Font, minimumScaleFactor: CGFloat = Sizes.minimumScaleFactor) -> Self {
        var copy = self
        copy.font = font
        copy.minimumScaleFactor = minimumScaleFactor
        return copy
    }
    
}

// MARK: - DefaultProfileStle
public struct DefaultProfileStyle: ProfileListStyle {
    
    public var width: CGFloat = Sizes.profileImageWidth
    public var height: CGFloat = Sizes.profileImageHeight
    
    public var strokeWidth: CGFloat = Sizes.profileStrokeWidth
    public var strokeColors: (seen: Color, unseen: Color) = (Colors.lightGray, Colors.lightGreen)
    
    public var hSpacing: CGFloat = Sizes.profileViewSpace
    public var vSpacing: CGFloat = Sizes.profileVStackSpace
    
    public var font: Font = Fonts.usernameFont
    public var minimumScaleFactor: CGFloat = Sizes.minimumScaleFactor
    public var textColor: Color = Color(.label)
}

// MARK: - DefaultProfileStyle Variable
extension ProfileListStyle where Self == DefaultProfileStyle {

    public static var `default`: DefaultProfileStyle { DefaultProfileStyle() }
}
