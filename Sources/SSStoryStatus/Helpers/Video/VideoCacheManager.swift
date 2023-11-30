//
//  VideoCacheManager.swift
//
//
//  Created by Krunal Patel on 01/11/23.
//

import AVKit

// MARK: - Video Cache Manager
class VideoCacheManager {
    
    // MARK: - Vars & Lets
    private let fileManager = FileManager.default
    private let videoRetriver = VideoRetriver.shared
    
    private lazy var cacheDirectoryURL = {
        let url = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: Paths.cacheDirectoryName)
        return url
    }()
    
    // MARK: - Methods
    func getVideo(for fileName: String) -> URL? {
        let fileURL = getFileUrl(for: fileName)
        
        guard fileManager.fileExists(atPath: fileURL.path()) else {
            return nil
        }
        
        return fileURL
    }
    
    func saveVideo(avAsset: AVAsset, fileName: String) async throws -> URL {
        let fileURL = getFileUrl(for: fileName)
        
        try await videoRetriver.exportVideo(avAsset: avAsset, outputURL: fileURL)
        return fileURL
    }
    
    private func getFileUrl(for fileName: String) -> URL {
        createFolderIfNeeded()
        return cacheDirectoryURL.appending(path: fileName)
    }
    
    private func createFolderIfNeeded() {
        guard !fileManager.fileExists(atPath: cacheDirectoryURL.path()) else { return }
        
        try? fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true)
    }
    
    
    // MARK: - Shared Instance
    static let shared = VideoCacheManager()
    
    // MARK: - Private Initializer
    private init() { }
}
