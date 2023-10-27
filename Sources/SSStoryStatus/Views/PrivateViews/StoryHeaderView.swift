//
//  StoryHeaderView.swift
//
//
//  Created by Krunal Patel on 27/10/23.
//

import SwiftUI

struct StoryHeaderView: View {
    
    @Environment(StoryViewModel.self) private var storyViewModel: StoryViewModel
    var user: UserModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.image)) { image in
                image.profileModifier()
            } placeholder: {
                Image(systemName: Images.placeholderProfile)
                    .placeholerModifier()
            }
            .frame(width: Sizes.profileImageSmallWidth, height: Sizes.profileImageSmallHeight)
            
            Text(user.name)
                .foregroundColor(Color(.label))
                .font(.system(size: Sizes.profileUsernameSize, design: .rounded))
                .fontWeight(.medium)
            
            Spacer()
            
            Button {
                storyViewModel.closeStoryView()
            } label: {
                Image(systemName: Images.closeMark)
                    .resizable()
                    .padding(Sizes.closeButtonPadding)
                    .tint(Color(.label))
                    .frame(width: Sizes.closeButtonSize, height: Sizes.closeButtonSize)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    StoryHeaderView(user: mockData[1])
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
