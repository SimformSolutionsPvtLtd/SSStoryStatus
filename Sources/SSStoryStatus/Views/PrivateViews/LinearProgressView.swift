//
//  LinearProgressView.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 07/11/23.
//

import SwiftUI

struct LinearProgressView: View {
    
    // MARK: - Vars & Lets
    @Environment(\.progressBarStyle) private var style
    var progress: Float = 0
    var total: Float = 1
    
    // MARK: - Body
    var body: some View {
        GeometryReader { proxy in
            Capsule()
                .fill(style.background)
                .overlay(alignment: .leading) {
                    Capsule()
                        .fill(style.foreground)
                        .frame(width: getPerfectProgress() * proxy.size.width)
                }
        }
        .frame(height: style.height)
    }
}

// MARK: - Methods
extension LinearProgressView {
    
    private func getPerfectProgress() -> CGFloat {
        CGFloat(progress / total).clamped(to: 0...1)
    }
}

// MARK: - Preview
#Preview {
    LinearProgressView()
}
