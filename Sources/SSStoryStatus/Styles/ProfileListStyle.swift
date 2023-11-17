//
//  ProfileListStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileListStyle Configuration
/// A configuration of a profile list.
///
/// When you define a custom profile list style that confirms to the
/// ``ProfileListStyle`` protocol, you use this configuration to create view
/// using ``ProfileListStyle/makeBody(configuration:)`` method. Method
/// takes `ProfileListStyleConfiguration` as input that contains all required
/// informations to create profile listing view.
public struct ProfileListStyleConfiguration {
    
    // MARK: - Vars & Lets
    /// List of users to display on profile listing view.
    public var users: [UserModel]
    
    /// A View builder that accepts user and returns ``Content`` view for profile listing.
    public var content: (UserModel) -> Content
    
    /// A closure to present story view for given user.
    /// When implementing custom style this should be called to present the
    /// story detail view.
    public var onSelect: UserSelectAction
    
    // MARK: - Content View
    /// A type-erased content of user.
    public struct Content : View {
        init<Content: View>(_ content: Content) {
          body = AnyView(content)
        }

        public var body: AnyView
    }
}

// MARK: - ProfileListStyle
/// A appearance and behaviour of profile listing.
///
/// You can configure the style using the ``SwiftUI/View/profileListStyle(_:)``
/// modifier.
///
/// You can use built-in style ``automatic`` with the default values or
/// with customization like ``DefaultProfileListStyle/horizontalSpacing(_:)``.
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .profileListStyle(.automatic)
/// ```
///
/// To create custom style, declare a type that confirms to `ProfileListStyle` and
/// implement the required ``makeBody(configuration:)`` method.
///
/// ```swift
/// struct VerticalProfileListStyle: ProfileListStyle {
///     func makeBody(configuration: Configuration) -> some View {
///         // Return a view listing users with vertical appearance and behaviour.
///     }
/// }
/// ```
///
/// Inside the method, use `configuration` parameter, which is instance of
/// ``ProfileListStyleConfiguration`` structure containing required informations
/// such as list of users and view builder for ``ProfileView``.
///
/// To provide easy access to the new style, declare a corresponding static variable in an
/// extension to `ProfileListStyle`.
///
/// ```swift
/// extension ProfileListStyle where Self == VerticalProfileListStyle {
///     static var vertical: VerticalProfileListStyle { .init() }
/// }
/// ```
///
/// You can then use it like:
///
/// ```swift
/// SSStoryStatus(users: mockData)
///     .profileListStyle(.vertical)
/// ```
public protocol ProfileListStyle {
    
    /// A view that represents the appearance of a profile listing.
    ///
    /// SwiftUI inters this type automatically based on the `View` instance returned
    /// form ``makeBody(configuration:)`` method.
    associatedtype Body : View
    
    /// Creates a view that represents the body of profile listing.
    ///
    /// Implement this method when defining custom style that confirms to
    /// ``ProfileListStyle`` protocol. Use the `configuration` instance of
    /// ``ProfileListStyleConfiguration`` to access required information.
    ///
    /// ```swift
    /// struct VerticalProfileListStyle: ProfileListStyle {
    ///     func makeBody(configuration: Configuration) -> some View {
    ///         ScrollView {
    ///             VStack {
    ///                 ForEach(configuration.users) { user in
    ///                     configuration.content(user) // get ProfileView for given user
    ///                         .onTapGesture {
    ///                             configuration.onSelect(user) // open story of user
    ///                         }
    ///                 }
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// Use ``ProfileListStyleConfiguration/users`` to get list of ``UserModel`` and implement
    /// tap gesture to open story of that user by calling ``ProfileListStyleConfiguration/onSelect``.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
    
    /// The properties of profile listing.
    ///
    /// You receive a `configuration` parameter of this type -- which is an alias for the
    /// ``ProfileListStyleConfiguration`` type -- when implementing
    /// ``makeBody(configuration:)`` method for custom style.
    typealias Configuration = ProfileListStyleConfiguration
}

// MARK: - Type Erased ProfileListStyle
struct AnyProfileListStyle: ProfileListStyle {
    
    private let _makeBody: (Configuration) -> AnyView
    
    init<S: ProfileListStyle>(_ style: S) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        return _makeBody(configuration)
    }
}

// MARK: - DefaultProfileListStyle
/// The default profile list style.
///
/// Use the ``ProfileListStyle/automatic`` to apply this style.
///
/// ```swift
/// SSStoryStatus(users: users)
///     .profileListStyle(.automatic)
/// ```
public struct DefaultProfileListStyle: ProfileListStyle {
    
    // MARK: - Vars & Lets
    /// A float value that represent spacing between the profile views.
    /// Default value is ``Sizes/profileViewSpace``.
    public var hSpacing: CGFloat = Sizes.profileViewSpace
    
    // MARK: - Body
    /// Creates a view that represents the body of a profile list.
    ///
    /// The default implementation for ``ProfileListStyle`` is implemented by default.
    /// The system calls this method for each `ProfileListView` when required.
    ///
    /// - Parameter configuration: The properties of profile list.
    /// - Returns: A view containing profile list appearance and behaviour.
    @ViewBuilder
    public func makeBody(configuration: Configuration) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: hSpacing) {
                ForEach(configuration.users) { user in
                    configuration.content(user)
                        .onTapGesture {
                            configuration.onSelect(user)
                        }
                }
            }
            .fixedSize()
        }
        .padding(.vertical)
        .padding(.horizontal)
        .scrollClipDisabled()
    }
}

// MARK: - Public Methods
extension DefaultProfileListStyle {
    
    // MARK: - Spaces
    /// Change default spacing between the profile views.
    ///
    /// You can use this method to change default spacing between profile view.
    /// ```swift
    /// SSStoryStatus(users: mockData)
    ///     .profileListStyle(.automatic.horizontalSpacing(14))
    /// ```
    ///
    /// - Parameter spacing: The space to apply between profile views.
    /// - Returns: A new style with given spacing.
    public func horizontalSpacing(_ spacing: CGFloat) -> Self {
        var copy = self
        copy.hSpacing = spacing
        return copy
    }
}

// MARK: - DefaultProfileStyle Variable
extension ProfileListStyle where Self == DefaultProfileListStyle {
    
    /// A profile list style containing default style appearance and behaviour.
    public static var automatic: DefaultProfileListStyle { .init() }
}
