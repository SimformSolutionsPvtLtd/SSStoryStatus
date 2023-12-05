//
//  StoryHeaderStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - StoryHeaderStyle Configuration
/// A configuration of a story header.
///
/// When you define a custom message field style that confirms to the
/// ``StoryHeaderStyle`` protocol, you use this configuration to create view
/// using ``StoryHeaderStyle/makeBody(configuration:imageModel:)`` method.
/// Method takes `StoryHeaderStyleConfiguration` as input that contains all required
/// informations to create message field.
public struct StoryHeaderStyleConfiguration {
    
    // MARK: - Vars & Lets
    /// The user information to display.
    public var user: UserModel
    
    /// The story information to display.
    public var story: StoryModel
    
    /// The dismiss action to close the story view.
    public var dismiss: DismissAction
    
    /// The progress view indicating current progress stats.
    public var progress: Progress
    
    // MARK: - Progress View
    /// A type-erased progress view.
    public struct Progress : View {
        init<Content: View>(_ content: Content) {
          body = AnyView(content)
        }

        public var body: AnyView
    }
}

// MARK: - StoryHeaderStyle
/// A appearance and behaviour  of story header.
///
/// To set the style pass and instance of type that confirms to `StoryHeaderStyle` protocol
/// to `headerStyle` in
/// ``SwiftUI/View/storyStyle(headerStyle:footerStyle:progressBarStyle:)``.
///
/// You can use built-in style ``automatic`` with the default values or
/// with customization like ``DefaultStoryHeaderStyle/dismissColor(_:)``.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(headerStyle: .automatic.dismissColor(.gray))
/// ```
///
/// To create custom style, declare a type that confirms to `StoryHeaderStyle` and
/// implement the required ``makeBody(configuration:imageModel:)`` method.
///
/// ```swift
/// struct MyStoryHeaderStyle: StoryHeaderStyle {
///     func makeBody(configuration: Configuration, imageModel: AsyncImageModel) -> some View {
///         // Return a view with user details and progress.
///     }
/// }
/// ```
///
/// Inside the method, use `configuration` parameter, which is instance of
/// ``StoryHeaderStyleConfiguration`` structure containing required informations
/// such as user/story information and dismiss action.
///
/// To provide easy access to the new style, declare a corresponding static variable in an
/// extension to `StoryHeaderStyle`.
///
/// ```swift
/// extension StoryHeaderStyle where Self == MyStoryHeaderStyle {
///     static var custom: MyStoryHeaderStyle { .init() }
/// }
/// ```
///
/// You can then use it like:
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(headerStyle: .custom)
/// ```
public protocol StoryHeaderStyle {
    
    /// A view that represents the appearance of a profile listing.
    ///
    /// SwiftUI inters this type automatically based on the `View` instance returned
    /// form ``makeBody(configuration:imageModel:)`` method.
    associatedtype Body : View
    
    /// Creates a view that represents the body of header.
    ///
    /// Implement this method when defining custom style that confirms to
    /// ``StoryHeaderStyle`` protocol. Use the `configuration` instance of
    /// ``StoryHeaderStyleConfiguration`` to access required information.
    @ViewBuilder func makeBody(configuration: Self.Configuration, imageModel: AsyncImageModel) -> Self.Body
    
    /// The properties of story header.
    ///
    /// You receive a `configuration` parameter of this type -- which is an alias for the
    /// ``StoryHeaderStyleConfiguration`` type -- when implementing
    /// ``makeBody(configuration:imageModel:)`` method for custom style.
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

// MARK: - DefaultStoryHeaderStyle
/// The default header style.
///
/// Use the ``StoryHeaderStyle/automatic`` to apply this style.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .storyStyle(headerStyle: .automatic)
/// ```
public struct DefaultStoryHeaderStyle: StoryHeaderStyle {
    
    // MARK: - Vars & Lets
    /// The width for profile image.
    public var profileWidth: CGFloat = Sizes.profileImageSmallWidth
    
    /// The height for profile image.
    public var profileHeight: CGFloat = Sizes.profileImageSmallHeight
    
    /// The font used for user name.
    public var nameFont: Font = Fonts.storyUsernameFont
    
    /// The color for username text.
    public var nameColor: Color = Color(.label)
    
    /// The font for date in header.
    public var dateFont: Font = Fonts.storyDateFont
    
    /// The color for date text in header.
    public var dateColor: Color = Color(.label).opacity(0.8)
    
    /// Dismiss image to close story view.
    public var dismissImage: Image = Image(systemName: Images.closeMark)
    
    /// The width of dismiss button.
    public var dismissWidth: CGFloat = Sizes.closeButtonSize
    
    /// The height of dismiss button.
    public var dismissHeight: CGFloat = Sizes.closeButtonSize
    
    /// The color of dismiss button.
    public var dismissColor: Color = Color(.label)
    
    /// The padding for dismiss button.
    public var dismissPadding: EdgeInsets = EdgeInsets(
        top: Sizes.closeButtonPadding,
        leading: Sizes.closeButtonPadding,
        bottom: Sizes.closeButtonPadding,
        trailing: Sizes.closeButtonPadding
    )
    
    // MARK: - Body
    /// Creates a view containing the body of a header view.
    ///
    /// The default implementation for ``StoryHeaderStyle`` is implemented by default.
    /// The system calls this method for each header view when required.
    ///
    /// - Parameters:
    ///   - configuration: The properties of user for header view.
    ///   - imageModel: A image model for fetching image with caching implementation.
    /// - Returns: A view containing profile appearance and behaviour.
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
    /// Set the width and height for profile view.
    ///
    /// - Parameters:
    ///   - width: The width to set on profile view.
    ///   - height: The height to set on profile view.
    /// - Returns: A new style with given width & height.
    public func profileSize(width: CGFloat, height: CGFloat) -> Self {
        var copy = self
        copy.profileWidth = width
        copy.profileHeight = height
        return copy
    }
    
    /// Sets the width and height for dismiss button.
    ///
    /// - Parameters:
    ///   - width: The width to set on dismiss button.
    ///   - height: The height to set on dismiss button.
    ///   - padding: The padding for dismiss button.
    /// - Returns: A style that uses given configurations.
    public func dismissSize(width: CGFloat, height: CGFloat, padding: EdgeInsets = EdgeInsets()) -> Self {
        var copy = self
        copy.dismissWidth = width
        copy.dismissHeight = height
        copy.dismissPadding = padding
        return copy
    }
    
    // MARK: - Colors
    /// Sets the text color for username.
    ///
    /// - Parameter color: The color to set on username text.
    /// - Returns: A new style with given username text color.
    public func nameColor(_ color: Color) -> Self {
        var copy = self
        copy.nameColor = color
        return copy
    }
    
    /// Sets the text color for date.
    ///
    /// - Parameter color: The color to set on date text.
    /// - Returns: A new style with given date text color.
    public func dateColor(_ color: Color) -> Self {
        var copy = self
        copy.dateColor = color
        return copy
    }
    
    /// Sets the text color for dismiss button,
    ///
    /// - Parameter color: The color to set on dismiss button.
    /// - Returns: A new style with given dismiss button color.
    public func dismissColor(_ color: Color) -> Self {
        var copy = self
        copy.dismissColor = color
        return copy
    }
    
    // MARK: - Images
    /// Sets the image of dismiss button.
    ///
    /// - Parameter image: The image to set on dismiss action.
    /// - Returns: A new style with given dismiss image.
    public func dismissImage(_ image: Image) -> Self {
        var copy = self
        copy.dismissImage = image
        return copy
    }
    
    // MARK: - Fonts
    /// Sets new font for username text.
    ///
    /// - Parameters:
    ///   - font: The font to set on username text.
    /// - Returns: A new style with given configurations.
    public func nameFont(_ font: Font) -> Self {
        var copy = self
        copy.nameFont = font
        return copy
    }
    
    /// Sets new font for date text.
    ///
    /// - Parameters:
    ///   - font: The font to set on date text.
    /// - Returns: A new style with given configurations.
    public func dateFont(_ font: Font) -> Self {
        var copy = self
        copy.dateFont = font
        return copy
    }
}

// MARK: - DefaultStoryHeaderStyle Variable
extension StoryHeaderStyle where Self == DefaultStoryHeaderStyle {
    
    /// A story header view style containing default style appearance and behaviour.
    public static var automatic: DefaultStoryHeaderStyle { .init() }
}
