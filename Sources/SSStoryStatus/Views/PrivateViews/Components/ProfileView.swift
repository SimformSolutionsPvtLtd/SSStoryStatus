//
//  ProfileView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

public struct ProfileView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.profileStyle) private var profileStyle
    @State private var imageModel = AsyncImageModel()
    private let configuration: ProfileStyle.Configuration
    
    public var body: some View {
        profileStyle.makeBody(configuration: configuration, imageModel: imageModel)
    }
    
    // MARK: - Initializer
    init(user: UserModel) {
        configuration = ProfileStyle.Configuration(user: user)
    }
}
