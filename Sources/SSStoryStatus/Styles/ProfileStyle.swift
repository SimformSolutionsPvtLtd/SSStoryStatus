//
//  ProfileStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileStyle Configuration
/// A configuration of a user profile.
///
/// When you define a custom profile list style that confirms to the
/// ``ProfileStyle`` protocol, you use this configuration to create view
/// using ``ProfileStyle/makeBody(configuration:imageModel:)`` method.
/// Method takes `ProfileListStyleConfiguration` as input that contains all the
/// required informations to create profile view.
public struct ProfileStyleConfiguration {
    
    // MARK: - Vars & Lets
    /// User information to display in profile view.
    public var user: UserModel
}

// MARK: - ProfileStyle
/// A appearance of profile view used in profile listing.
///
/// This style is used to create profile view for ``ProfileListStyle``. You
/// can configure the style using the ``SwiftUI/View/profileStyle(_:)``
/// modifier.
///
/// You can use built-in style ``automatic`` with the default values or
/// customize with methods available in ``DefaultProfileStyle``.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .profileStyle(.automatic)
/// ```
///
/// To create custom style, declare a type that confirms to `ProfileStyle` and
/// implement the required ``makeBody(configuration:imageModel:)`` method.
///
/// ```swift
/// struct MyProfileStyle: ProfileStyle {
///     func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
///         // Return a profile view with custom appearance and behaviour.
///     }
/// }
/// ```
///
/// Inside the method, use `configuration` parameter, which is instance of
/// ``ProfileStyleConfiguration`` structure containing required informations
/// for user profile view like ``UserModel``.
///
/// To provide easy access to the new style, declare a corresponding static variable in an
/// extension to `ProfileStyle`.
///
/// ```swift
/// extension ProfileStyle where Self == MyProfileStyle {
///     static var custom: MyProfileListStyle { .init() }
/// }
/// ```
///
/// You can then use it like:
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .profileStyle(.custom)
/// ```
public protocol ProfileStyle {
    
    /// A view that represents the appearance of a profile listing.
    ///
    /// SwiftUI inters this type automatically based on the `View` instance returned
    /// form ``makeBody(configuration:imageModel:)`` method.
    associatedtype Body : View
    
    /// Creates a view that represents the body of user profile.
    ///
    /// Implement this method when defining custom style that confirms to
    /// ``ProfileStyle`` protocol. Use the `configuration` instance of
    /// ``ProfileStyleConfiguration`` to access required information.
    ///
    /// ```swift
    /// struct MyProfileStyle: ProfileStyle {
    ///     func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
    ///         HStack {
    ///             getImageView(model: imageModel)
    ///
    ///             Text(user.name)
    ///                 .font(.system(size: 18))
    ///         }
    ///     }
    ///
    ///     // Get the profile image from image model asynchronously.
    ///     private func getImageView(model imageModel: AsyncImageModel) -> some View {
    ///         CachedAsyncImage(imageModel: imageModel) { phase in
    ///             switch phase {
    ///             case .success(let image):
    ///                 image
    ///             default:
    ///                 Image(systemName: "photo.circle.fill")
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// Use ``ProfileListStyleConfiguration/users`` to get list of ``UserModel`` and implement
    /// tap gesture to open story of that user by calling ``ProfileListStyleConfiguration/onSelect``.
    @ViewBuilder func makeBody(configuration: Self.Configuration, imageModel: AsyncImageModel) -> Self.Body
    
    /// The properties of user profile.
    ///
    /// You receive a `configuration` parameter of this type -- which is an alias for the
    /// ``ProfileStyleConfiguration`` type -- when implementing
    /// ``makeBody(configuration:imageModel:)`` method for custom style.
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

// MARK: - DefaultProfileStyle
/// The default profile view style.
///
/// Use the ``ProfileStyle/automatic`` to apply this style.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .profileStyle(.automatic)
/// ```
public struct DefaultProfileStyle: ProfileStyle {
    
    // MARK: - Vars & Lets
    /// The width of profile view.
    public var width: CGFloat = Sizes.profileImageWidth
    
    /// The height of profile view.
    public var height: CGFloat = Sizes.profileImageHeight
    
    /// The width of stroke for circular progress.
    public var strokeWidth: CGFloat = Sizes.profileStrokeWidth
    
    /// Stroke shape style for seen and unseen story progress portion.
    public var strokeStyles: (seen: AnyShapeStyle, unseen: AnyShapeStyle) = (AnyShapeStyle(Colors.lightGray), AnyShapeStyle(Colors.lightGreen))
    
    /// The space between user profile image and username text.
    public var vSpacing: CGFloat = Sizes.profileVStackSpace
    
    /// The font for username.
    public var font: Font = Fonts.usernameFont
    
    /// The scale factor for the username text.
    public var minimumScaleFactor: CGFloat = Sizes.minimumScaleFactor
    
    /// Color for the username text font.
    public var textColor: Color = Color(.label)
    
    // MARK: - Body
    /// Creates a view containing the body of a user profile view.
    ///
    /// The default implementation for ``ProfileStyle`` is implemented by default.
    /// The system calls this method for each `ProfileView` when required.
    ///
    /// - Parameters:
    ///   - configuration: The properties of user for profile view.
    ///   - imageModel: A image model for fetching image with caching implementation.
    /// - Returns: A view containing profile appearance and behaviour.
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
    /// Sets the width and height for profile view.
    ///
    /// - Parameters:
    ///   - width: The width to set on profile view.
    ///   - height: The height to set on profile view.
    /// - Returns: A new style with given width & height.
    public func profileSize(width: CGFloat, height: CGFloat) -> Self {
        var copy = self
        copy.width = width
        copy.height = height
        return copy
    }
    
    /// Sets the stroke width for circular progress.
    ///
    /// Change the width of stroke for circular progress view around profile image.
    ///
    /// - Parameter width: The width of a stroke.
    /// - Returns: A new style with given stroke width.
    public func strokeWidth(_ width: CGFloat) -> Self {
        var copy = self
        copy.strokeWidth = width
        return copy
    }
    
    // MARK: - Colors
    /// Set the stroke style for circular progress view.
    ///
    /// You can provide style that confirms to `ShapeStyle` protocol for seen &
    /// unseen partition.
    ///
    /// ```swift
    /// SSStoryStatus(users: mockData)
    ///     .profileStyle(
    ///         .automatic
    ///             .strokeStyles(
    ///                 seen: .gray,
    ///                 unseen: .linearGradient(colors: [.green, .orange], startPoint: .top, endPoint: .bottom)
    ///             )
    ///     )
    /// ```
    ///
    /// - Parameters:
    ///   - seen: The shape style for seen partition.
    ///   - unseen: The shape style for unseen partition.
    /// - Returns: A new style with given seen/unseen style.
    public func strokeStyles<S1: ShapeStyle, S2: ShapeStyle>(seen: S1, unseen: S2) -> Self {
        var copy = self
        copy.strokeStyles = (AnyShapeStyle(seen), AnyShapeStyle(unseen))
        return copy
    }
    
    /// Sets the text color for username.
    ///
    /// - Parameter color: The color to set on username text.
    /// - Returns: A new style with given username text color.
    public func textColor(_ color: Color) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }
    
    // MARK: - Spaces
    /// Sets the space between profile image and username text.
    ///
    /// - Parameter spacing: The space to set.
    /// - Returns: A new style with given space.
    public func imageUsernameSpacing(_ spacing: CGFloat) -> Self {
        var copy = self
        copy.vSpacing = spacing
        return copy
    }
    
    // MARK: - Fonts
    /// Sets new font for username text.
    ///
    /// - Parameters:
    ///   - font: The font to set on username text.
    ///   - minimumScaleFactor: Sets the minimum amount that text in this view scales down to fit in the
    ///   available space.
    /// - Returns: A new style with given configurations.
    public func font(_ font: Font, minimumScaleFactor: CGFloat = Sizes.minimumScaleFactor) -> Self {
        var copy = self
        copy.font = font
        copy.minimumScaleFactor = minimumScaleFactor
        return copy
    }
    
}

// MARK: - DefaultProfileStyle Variable
extension ProfileStyle where Self == DefaultProfileStyle {
    
    /// A profile view style containing default style appearance and behaviour.
    public static var automatic: DefaultProfileStyle { .init() }
}
