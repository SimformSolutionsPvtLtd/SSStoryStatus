//
//  Comparable+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 30/10/23.
//

// MARK: - Comparable Extension
extension Comparable {
    
    // MARK: - Clamp
    /// Clamps the value to given range.
    ///
    /// - Parameter limits: The range containing upper and lower bound.
    /// - Returns: A new clamped value within given range.
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
