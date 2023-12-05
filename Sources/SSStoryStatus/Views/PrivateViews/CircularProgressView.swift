//
//  CircularProgressView.swift
//
//
//  Created by Krunal Patel on 07/11/23.
//

import SwiftUI

struct CircularProgressView: View {
    
    // MARK: - Vars & Lets
    private let radius: CGFloat
    private let totalStories: Int
    private let seenStories: Int
    private var colors: (seen: Color, unseen: Color)
    private let lineWidth = Sizes.profileStrokeWidth
    private let dashLength: CGFloat
    private var space: CGFloat = 0
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .trim(from: calculateFraction(), to: 1)
                .rotation(Angles.trimAngle)
                .stroke(colors.unseen, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            
            Circle()
                .trim(from: 0, to: calculateFraction())
                .rotation(Angles.trimAngle)
                .stroke(colors.seen, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
        }
        .clipShape(dashedCircle)
    }
    
    // MARK: - Shape
    private var dashedCircle: some Shape {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: [dashLength - space, space], dashPhase: Angles.dashPhase))
    }
    
    // MARK: - Initializer
    init(radius: CGFloat, totalStories: Int, seenStories: Int = 0, colors: (seen: Color, unseen: Color) = (Colors.lightGray, Colors.lightGreen)) {
        self.radius = radius
        self.totalStories = totalStories
        self.seenStories = seenStories
        self.colors = colors
        dashLength = (2 * .pi * radius) / CGFloat(totalStories)
        space = calculateSpace()
    }
}

// MARK: - Methods
extension CircularProgressView {
    
    // Space between progress partitions
    private func calculateSpace() -> CGFloat {
        switch totalStories {
        case 1:
            return 0
        case 2...25:
            return Sizes.fixedProgressPartitionSpacing
        default:
            return dashLength * Sizes.progressPartitionPercentage
        }
    }
    
    // Starting trim fraction for unseen stories, Ending trim fraciton for seen stories
    private func calculateFraction() -> CGFloat {
        CGFloat(seenStories) / CGFloat(totalStories)
    }
}

// MARK: - Preview
#Preview {
    CircularProgressView(radius: Sizes.profileImageWidth / 2, totalStories: mockData[0].stories.count, seenStories: mockData[0].seenStoriesCount)
}
