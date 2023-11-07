//
//  Comparable+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 30/10/23.
//

// MARK: - Comparable Extension
extension Comparable {
    
    // MARK: - Clamp
    // clamp value to given range
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
