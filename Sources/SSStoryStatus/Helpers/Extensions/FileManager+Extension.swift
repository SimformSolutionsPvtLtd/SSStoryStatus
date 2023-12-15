//
//  FileManager+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 08/11/23.
//

import Foundation

// MARK: - FileManager Extension
extension FileManager {
    
    // MARK: - Clear Cache
    // Clear cache directory items older than given date
    func clearCache(directory url: URL, olderThan date: Date) {
        guard let enumerator = enumerator(at: url, includingPropertiesForKeys: [.creationDateKey]) else {
            return
        }
        
        enumerator
            .compactMap { $0 as? URL }
            .forEach { fileURL in
                do {
                    let attrs = try attributesOfItem(atPath: fileURL.path())
                    
                    if let creationDate = attrs[.creationDate] as? Date,
                       creationDate < date {
                        try removeItem(at: fileURL)
                    }
                } catch { }
            }
    }
}
