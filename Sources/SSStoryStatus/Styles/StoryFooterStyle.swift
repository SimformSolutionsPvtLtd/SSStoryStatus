//
//  StoryFooterStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 16/11/23.
//

import SwiftUI

// MARK: - StoryFooterStyle Configuration
public struct StoryFooterStyleConfiguration {
    
    // MARK: - Vars & Lets
    var story: StoryModel
    var reaction: Reaction
    
    // MARK: - Reaction View
    public struct Reaction : View {
        init<Content: View>(_ content: Content) {
          body = AnyView(content)
        }

        public var body: AnyView
    }
}

// MARK: - StoryFooterStyle
public protocol StoryFooterStyle {
    
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration, focused: FocusState<Bool>.Binding) -> Self.Body
    
    typealias Configuration = StoryFooterStyleConfiguration
}

// MARK: - Type Erased StoryFooterStyle
struct AnyStoryFooterStyle: StoryFooterStyle {
    
    private let _makeBody: (Configuration, FocusState<Bool>.Binding) -> AnyView
    
    init<S: StoryFooterStyle>(_ style: S) {
        _makeBody = { configuration, focused in
            AnyView(style.makeBody(configuration: configuration, focused: focused))
        }
    }
    
    func makeBody(configuration: Configuration, focused: FocusState<Bool>.Binding) -> some View {
        return _makeBody(configuration, focused)
    }
}

// MARK: - DefaultStoryFooterStyle {
public struct DefaultStoryFooterStyle: StoryFooterStyle {
    
    // MARK: - Vars & Lets
    public var captionFont: Font = Fonts.storyCaption
    public var captionColor: Color = Color(.label)
    
    // MARK: - Body
    @ViewBuilder
    public func makeBody(configuration: Configuration, focused: FocusState<Bool>.Binding) -> some View {
        
        VStack {
            if !focused.wrappedValue {
                getCaptionView(configuration.story.caption)
            }
            
            configuration.reaction
        }
    }
}

// MARK: - Private Views
extension DefaultStoryFooterStyle {

    private func getCaptionView(_ caption: String) -> some View {
        Text(caption)
            .font(captionFont)
            .foregroundStyle(captionColor)
    }
}

// MARK: - Public Methods
extension DefaultStoryFooterStyle {
    
    // MARK: - Colors
    public func captionColor(_ color: Color) -> Self {
        var copy = self
        copy.captionColor = color
        return copy
    }
    
    // MARK: - Fonts
    public func captionFont(_ font: Font) -> Self {
        var copy = self
        copy.captionFont = font
        return copy
    }
}

// MARK: - DefaultStoryFooterStyle Variable
extension StoryFooterStyle where Self == DefaultStoryFooterStyle {
    
    public static var automatic: DefaultStoryFooterStyle { DefaultStoryFooterStyle() }
}
