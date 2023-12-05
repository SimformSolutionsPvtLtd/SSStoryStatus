//
//  UserView.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

public struct UserView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.profileStyle) var profileStyle
    @State private var imageModel = AsyncImageModel()
    var user: UserModel
    
    // MARK: - Body
    public var body: some View {
        VStack(spacing: profileStyle.vSpacing) {
            ZStack {
                CircularProgressView(radius: profileStyle.width / 2, totalStories: user.stories.count, seenStories: user.seenStoriesCount, colors: profileStyle.strokeColors)
                
                profileImageView
            }
            .frame(width: profileStyle.width, height: profileStyle.height)
            
            Text(user.name)
                .font(profileStyle.font)
                .minimumScaleFactor(profileStyle.minimumScaleFactor)
                .lineLimit(1)
                .frame(width: profileStyle.width)
        }
    }
    
    // MARK: - Private Views
    private var profileImageView: some View {
        CachedAsyncImage(imageModel: imageModel) { phase in
            switch phase {
            case .success(let image):
                image
                    .profileModifier()
            case .failure(_):
                Image(systemName: Images.error)
                    .placeholerModifier()
            case .empty:
                Image(systemName: Images.placeholderImage)
                    .placeholerModifier()
            @unknown default:
                Image(systemName: Images.placeholderImage)
                    .placeholerModifier()
            }
        }
        .padding(Sizes.profileStrokeSpace)
        .onAppear {
            imageModel.getImage(url: URL(string: user.image))
        }
    }
}

// MARK: - Preview
#Preview {
    UserView(user: mockData[0])
        .previewLayout(.sizeThatFits)
}
