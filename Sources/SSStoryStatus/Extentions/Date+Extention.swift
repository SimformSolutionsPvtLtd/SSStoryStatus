//
//  Date+Extention.swift
//
//
//  Created by Krunal Patel on 02/11/23.
//

import Foundation

// MARK: - Date Extentions
extension Date {
    
    // MARK: - Relative Date
    func getRelative(unitsStyle: Date.RelativeFormatStyle.UnitsStyle = .wide, presentation: Date.RelativeFormatStyle.Presentation = .named) -> String {
        var formatter = Date.RelativeFormatStyle()
        formatter.unitsStyle = unitsStyle
        formatter.presentation = presentation
        return formatter.format(self)
    }
}
