//
//  UserView.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

struct UserView: View {
    
    // MARK: - Vars & Lets
    @State var imageModel = AsyncImageModel()
    var user: UserModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: Sizes.profileVStackSpace) {
            ZStack {
                Circle()
                    .stroke(user.isAllStoriesSeen ? Colors.lightGray : Colors.lightGreen, lineWidth: Sizes.profileStrokeWidth)
                
                profileImageView
            }
            .padding(Sizes.profileStrokeWidth)
            .frame(width: Sizes.profileImageWidth, height: Sizes.profileImageHeight)
            
            Text(user.name)
                .foregroundColor(Color(.label))
                .font(.system(size: Sizes.profileUsernameSize, design: .rounded))
                .fontWeight(.medium)
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
