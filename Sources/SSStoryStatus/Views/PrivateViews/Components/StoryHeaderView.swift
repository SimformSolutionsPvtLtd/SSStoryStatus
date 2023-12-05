//
//  StoryHeaderView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 27/10/23.
//

import SwiftUI

public struct StoryHeaderView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.storyHeaderStyle) private var storyHeaderStyle
    @State private var imageModel = AsyncImageModel()
    private let configuration: StoryHeaderStyle.Configuration
    
    // MARK: - Body
    public var body: some View {
        storyHeaderStyle.makeBody(configuration: configuration, imageModel: imageModel)
    }
    
    // MARK: - Initializer
    init(user: UserModel, story: StoryModel, dismiss: DismissAction) {
        configuration = StoryHeaderStyle.Configuration(
            user: user,
            story: story,
            dismiss: dismiss,
            progress: .init(StoryProgressView())
        )
    }
}

// MARK: - Preview
#Preview {
    ProfileView(user: mockData[0])
        .previewLayout(.sizeThatFits)
}
