//
//  Image+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI

// MARK: - Image Extension
extension Image {
    
    // MARK: - Placeholder Modifier
    func placeholderModifier() -> some View {
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

