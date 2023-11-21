//
//  Comparable+Extention.swift
//
//
//  Created by Krunal Patel on 30/10/23.
//

// MARK: - Clam value within bound
extension Comparable {
    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
