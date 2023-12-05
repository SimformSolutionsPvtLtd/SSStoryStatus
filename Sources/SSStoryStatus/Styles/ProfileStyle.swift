//
//  ProfileStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileStyle Configuration
public struct ProfileStyleConfiguration {
    
    // MARK: - Vars & Lets
    var user: UserModel
}

// MARK: - ProfileStyle
public protocol ProfileStyle {
    
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration, imageModel: AsyncImageModel) -> Self.Body
    
    typealias Configuration = ProfileStyleConfiguration
}

// MARK: - Type Erased ProfileStyle
struct AnyProfileStyle: ProfileStyle {
    
    private let _makeBody: (Configuration, AsyncImageModel) -> AnyView
    
    init<S: ProfileStyle>(_ style: S) {
        _makeBody = { configuration, imageModel in
            AnyView(style.makeBody(configuration: configuration, imageModel: imageModel))
        }
    }
    
    func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
        
        return _makeBody(configuration, imageModel)
    }
}

// MARK: - DefaultProfileStyle {
public struct DefaultProfileStyle: ProfileStyle {
    
    // MARK: - Vars & Lets
    public var width: CGFloat = Sizes.profileImageWidth
    public var height: CGFloat = Sizes.profileImageHeight
    
    public var strokeWidth: CGFloat = Sizes.profileStrokeWidth
    public var strokeStyles: (seen: AnyShapeStyle, unseen: AnyShapeStyle) = (AnyShapeStyle(Colors.lightGray), AnyShapeStyle(Colors.lightGreen))
    
    public var vSpacing: CGFloat = Sizes.profileVStackSpace
    
    public var font: Font = Fonts.usernameFont
    public var minimumScaleFactor: CGFloat = Sizes.minimumScaleFactor
    public var textColor: Color = Color(.label)
    
    // MARK: - Body
    @ViewBuilder
    public func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
        let user = configuration.user
        
        VStack(spacing: vSpacing) {
            ZStack {
                CircularProgressView(radius: width / 2, totalStories: user.stories.count, seenStories: user.seenStoriesCount, styles: strokeStyles, lineWidth: strokeWidth)
                
                getImageView(model: imageModel)
                    .onAppear {
                        imageModel.enableResizing(size: CGSize(width: width, height: height))
                        imageModel.getImage(url: URL(string: user.image), type: .profile)
                    }
            }
            .frame(width: width, height: height)
            
            Text(user.name)
                .font(font)
                .minimumScaleFactor(minimumScaleFactor)
                .lineLimit(1)
                .frame(width: width)
        }
    }
}

// MARK: - Private Views
extension DefaultProfileStyle {
    
    private func getImageView(model imageModel: AsyncImageModel) -> some View {
        CachedAsyncImage(imageModel: imageModel) { phase in
            switch phase {
            case .success(let image):
                image
                    .profileModifier()
            case .failure(_):
                Image(systemName: Images.error)
                    .placeholderModifier()
            case .empty:
                Image(systemName: Images.placeholderImage)
                    .placeholderModifier()
            @unknown default:
                Image(systemName: Images.placeholderImage)
                    .placeholderModifier()
            }
        }
        .padding(Sizes.profileStrokeSpace)
    }
}

// MARK: - Public Methods
extension DefaultProfileStyle {
    
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
    public func strokeStyles<S1: ShapeStyle, S2: ShapeStyle>(seen: S1, unseen: S2) -> Self {
        var copy = self
        copy.strokeStyles = (AnyShapeStyle(seen), AnyShapeStyle(unseen))
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
    
    // MARK: - Fonts
    public func font(_ font: Font, minimumScaleFactor: CGFloat = Sizes.minimumScaleFactor) -> Self {
        var copy = self
        copy.font = font
        copy.minimumScaleFactor = minimumScaleFactor
        return copy
    }
    
}

// MARK: - DefaultProfileStyle Variable
extension ProfileStyle where Self == DefaultProfileStyle {
    
    public static var automatic: DefaultProfileStyle { DefaultProfileStyle() }
}
