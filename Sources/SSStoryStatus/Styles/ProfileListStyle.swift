//
//  ProfileListStyle.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 06/11/23.
//

import SwiftUI

// MARK: - ProfileListStyle Configuration
public struct ProfileListStyleConfiguration {
    
    // MARK: - Vars & Lets
    var users: [UserModel]
    var content: (UserModel) -> Content
    var onSelect: UserSelectAction
    
    // MARK: - Content View
    public struct Content : View {
        init<Content: View>(_ content: Content) {
          body = AnyView(content)
        }

        public var body: AnyView
    }
}

// MARK: - ProfileListStyle
public protocol ProfileListStyle {
    
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
    
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

// MARK: - DefaultProfileListStyle {
public struct DefaultProfileListStyle: ProfileListStyle {
    
    // MARK: - Vars & Lets
    public var hSpacing: CGFloat = Sizes.profileViewSpace
    
    // MARK: - Body
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
    public func horizontalSpacing(_ spacing: CGFloat) -> Self {
        var copy = self
        copy.hSpacing = spacing
        return copy
    }
}

// MARK: - DefaultProfileStyle Variable
extension ProfileListStyle where Self == DefaultProfileListStyle {
    
    public static var automatic: DefaultProfileListStyle { DefaultProfileListStyle() }
}
