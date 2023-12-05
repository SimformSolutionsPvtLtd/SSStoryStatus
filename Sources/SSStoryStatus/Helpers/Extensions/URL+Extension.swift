//
//  URL+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 07/11/23.
//

import Foundation
import CryptoKit

// MARK: - URL Extension
extension URL {
    
    // MARK: - MD5 String
    // Convert URL to MD5 hash
    var md5String: String {
        let digest = Insecure.MD5.hash(data: dataRepresentation)
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
