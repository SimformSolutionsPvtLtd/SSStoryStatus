//
//  StoryStyle.swift
//
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

public protocol StoryStyle {
    
    var profileWidth: CGFloat { get set }
    var profileHeight: CGFloat { get set }
    
    var nameFont: Font { get set }
    var nameColor: Color { get set }
    
    var dateFont: Font { get set }
    var dateColor: Color { get set }
    
    var progressbarColor: Color { get set }
    
    var dismissImage: Image { get set }
    var dismissWidth: CGFloat { get set }
    var dismissHeight: CGFloat { get set }
    var dismissColor: Color { get set }
    var dismissPadding: EdgeInsets { get set }
}

// MARK: - Public Methods
extension StoryStyle {
    
    // MARK: - Sizes
    public func profileSize(width: CGFloat, height: CGFloat) -> Self {
        var copy = self
        copy.profileWidth = width
        copy.profileHeight = height
        return copy
    }
    
    public func dismissSize(width: CGFloat, height: CGFloat, padding: EdgeInsets = EdgeInsets()) -> Self {
        var copy = self
        copy.dismissWidth = width
        copy.dismissHeight = height
        copy.dismissPadding = padding
        return copy
    }
    
    // MARK: - Colors
    public func nameColor(_ color: Color) -> Self {
        var copy = self
        copy.nameColor = color
        return copy
    }
    
    public func dateColor(_ color: Color) -> Self {
        var copy = self
        copy.dateColor = color
        return copy
    }
    
    public func progressbarColor(_ color: Color) -> Self {
        var copy = self
        copy.progressbarColor = color
        return copy
    }
    
    public func dismissColor(_ color: Color) -> Self {
        var copy = self
        copy.dismissColor = color
        return copy
    }
    
    // MARK: - Images
    public func dismissImage(_ image: Image) -> Self {
        var copy = self
        copy.dismissImage = image
        return copy
    }
    
    // MARK: - Fonts
    public func nameFont(_ font: Font) -> Self {
        var copy = self
        copy.nameFont = font
        return copy
    }
    
    public func dateFont(_ font: Font) -> Self {
        var copy = self
        copy.dateFont = font
        return copy
    }
}

// MARK: - DefaultStoryStyle
public struct DefaultStoryStyle: StoryStyle {
    
    public var profileWidth: CGFloat = Sizes.profileImageSmallWidth
    public var profileHeight: CGFloat = Sizes.profileImageSmallHeight
    
    public var nameFont: Font = Fonts.storyUsernameFont
    public var nameColor: Color = Color(.label)

    public var dateFont: Font = Fonts.storyDateFont
    public var dateColor: Color = Color(.lightGray)
    
    public var progressbarColor: Color = .white
    
    public var dismissImage: Image = Image(systemName: Images.closeMark)
    public var dismissWidth: CGFloat = Sizes.closeButtonSize
    public var dismissHeight: CGFloat = Sizes.closeButtonSize
    public var dismissColor: Color = Color(.label)
    public var dismissPadding: EdgeInsets = EdgeInsets(
        top: Sizes.closeButtonPadding,
        leading: Sizes.closeButtonPadding,
        bottom: Sizes.closeButtonPadding,
        trailing: Sizes.closeButtonPadding
    )
    
    public init() { }
}

// MARK: - DefaultStoryStyle Variable
extension StoryStyle where Self == DefaultStoryStyle {

    public static var `default`: DefaultStoryStyle { DefaultStoryStyle() }
}
