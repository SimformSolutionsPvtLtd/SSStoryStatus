//
//  StoryHeaderView.swift
//
//
//  Created by Krunal Patel on 27/10/23.
//

import SwiftUI

struct StoryHeaderView: View {
    
    // MARK: - Vars & Lets
    @Environment(StoryViewModel.self) private var storyViewModel: StoryViewModel
    var user: UserModel
    let dismiss: DismissAction
    
    // MARK: - Body
    var body: some View {
        HStack {
            profileImageView
            
            Text(user.name)
                .foregroundColor(Color(.label))
                .font(.system(size: Sizes.profileUsernameSize, design: .rounded))
                .fontWeight(.medium)
            
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
        
        CachedAsyncImage(url: URL(string: user.image)) { phase in
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
        .frame(width: Sizes.profileImageSmallWidth, height: Sizes.profileImageSmallHeight)
    }
    
    private var closeButtonImage: some View {
        Image(systemName: Images.closeMark)
            .resizable()
            .padding(Sizes.closeButtonPadding)
            .tint(Color(.label))
            .frame(width: Sizes.closeButtonSize, height: Sizes.closeButtonSize)
    }
}

// MARK: - Preview
#Preview {
    @Environment(\.dismiss) var dismiss
    
    return StoryHeaderView(user: mockData[1], dismiss: dismiss)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
