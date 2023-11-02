//
//  StoryHeaderView.swift
//
//
//  Created by Krunal Patel on 27/10/23.
//

import SwiftUI

struct StoryHeaderView: View {
    
    // MARK: - Vars & Lets
    @Environment(StoryViewModel.self) private var storyViewModel
    @Environment(\.storyStyle) private var storyStyle
    @State var imageModel = AsyncImageModel()
    var user: UserModel
    let story: StoryModel
    let dismiss: DismissAction
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: Sizes.headerSpacing) {
            profileImageView
            
            Text(user.name)
                .foregroundStyle(storyStyle.nameColor)
                .font(storyStyle.nameFont)
            
            storyRelativeDateView
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                closeButtonImage
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Private Views
    private var profileImageView: some View {
        
        CachedAsyncImage(imageModel: imageModel) { phase in
            switch phase {
            case .success(let image):
                image.profileModifier()
            case .failure(_):
                Image(systemName: Images.error)
                    .placeholerModifier()
            case .empty:
                Image(systemName: Images.placeholderProfile)
                    .placeholerModifier()
            @unknown default:
                Image(systemName: Images.placeholderProfile)
                    .placeholerModifier()
            }
        }
        .frame(width: storyStyle.profileWidth, height: storyStyle.profileHeight)
        .onAppear {
            imageModel.getImage(url: URL(string: user.image))
        }
    }
    
    private var storyRelativeDateView: some View {
        Text(story.date.getRelative())
            .foregroundStyle(storyStyle.dateColor)
            .font(storyStyle.dateFont)
    }
    
    private var closeButtonImage: some View {
        storyStyle.dismissImage
            .resizable()
            .scaledToFit()
            .tint(storyStyle.dismissColor)
            .padding(storyStyle.dismissPadding)
            .frame(width: storyStyle.dismissWidth, height: storyStyle.dismissHeight)
    }
}

// MARK: - Preview
#Preview {
    @Environment(\.dismiss) var dismiss
    
    return StoryHeaderView(user: mockData[1],story: mockData[1].stories[0], dismiss: dismiss)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
