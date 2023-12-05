//
//  StoryHeaderStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - StoryHeaderStyle Configuration
public struct StoryHeaderStyleConfiguration {
    
    // MARK: - Vars & Lets
    var user: UserModel
    var story: StoryModel
    var dismiss: DismissAction
    var progress: Progress
    
    // MARK: - Progress View
    public struct Progress : View {
        init<Content: View>(_ content: Content) {
          body = AnyView(content)
        }

        public var body: AnyView
    }
}

// MARK: - StoryHeaderStyle
public protocol StoryHeaderStyle {
    
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration, imageModel: AsyncImageModel) -> Self.Body
    
    typealias Configuration = StoryHeaderStyleConfiguration
}

// MARK: - Type Erased StoryHeaderStyle
struct AnyStoryHeaderStyle: StoryHeaderStyle {
    
    private let _makeBody: (Configuration, AsyncImageModel) -> AnyView
    
    init<S: StoryHeaderStyle>(_ style: S) {
        _makeBody = { configuration, imageModel in
            AnyView(style.makeBody(configuration: configuration, imageModel: imageModel))
        }
    }
    
    func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
        return _makeBody(configuration, imageModel)
    }
}

// MARK: - DefaultStoryHeaderStyle {
public struct DefaultStoryHeaderStyle: StoryHeaderStyle {
    
    // MARK: - Vars & Lets
    public var profileWidth: CGFloat = Sizes.profileImageSmallWidth
    public var profileHeight: CGFloat = Sizes.profileImageSmallHeight
    
    public var nameFont: Font = Fonts.storyUsernameFont
    public var nameColor: Color = Color(.label)
    
    public var dateFont: Font = Fonts.storyDateFont
    public var dateColor: Color = Color(.label).opacity(0.8)
    
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
    
    // MARK: - Body
    @ViewBuilder
    public func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
        
        VStack {
            
            configuration.progress
            
            HStack(spacing: Sizes.headerSpacing) {
                getImageView(model: imageModel)
                    .shadow(color: .black, radius: 10)
                    .onAppear {
                        imageModel.enableResizing(size: CGSize(width: profileWidth, height: profileHeight))
                        imageModel.getImage(url: URL(string: configuration.user.image), type: .profile)
                    }
                
                Text(configuration.user.name)
                    .foregroundStyle(nameColor)
                    .font(nameFont)
                    .shadow(color: .black, radius: 10)
                
                getRelativeDateView(configuration.story)
                    .shadow(color: .black, radius: 10)
                
                Spacer()
                
                Button {
                    configuration.dismiss()
                } label: {
                    closeButtonImage
                        .shadow(color: .black, radius: 10)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Private Views
extension DefaultStoryHeaderStyle {
    
    private func getImageView(model imageModel: AsyncImageModel) -> some View {
        CachedAsyncImage(imageModel: imageModel) { phase in
            switch phase {
            case .success(let image):
                image.profileModifier()
            case .failure(_):
                Image(systemName: Images.error)
                    .placeholderModifier()
            case .empty:
                Image(systemName: Images.placeholderProfile)
                    .placeholderModifier()
            @unknown default:
                Image(systemName: Images.placeholderProfile)
                    .placeholderModifier()
            }
        }
        .frame(width: profileWidth, height: profileHeight)
    }
    
    private func getRelativeDateView(_ story: StoryModel) -> some View {
        Text(story.date.getRelative())
            .foregroundStyle(dateColor)
            .font(dateFont)
    }
    
    private var closeButtonImage: some View {
        dismissImage
            .resizable()
            .scaledToFit()
            .tint(dismissColor)
            .padding(dismissPadding)
            .frame(width: dismissWidth, height: dismissHeight)
    }
}

// MARK: - Public Methods
extension DefaultStoryHeaderStyle {
    
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

// MARK: - DefaultStoryHeaderStyle Variable
extension StoryHeaderStyle where Self == DefaultStoryHeaderStyle {
    
    public static var automatic: DefaultStoryHeaderStyle { DefaultStoryHeaderStyle() }
}
