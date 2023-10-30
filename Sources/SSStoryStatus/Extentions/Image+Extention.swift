//
//  Image+Extention.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

// MARK: - Image Modifiers
extension Image {
    
    // MARK: - Placeholder Modifier
    func placeholerModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .opacity(0.6)
    }
    
    // MARK: - Profile Modifier
    func profileModifier() -> some View {
        self
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
    }
}

