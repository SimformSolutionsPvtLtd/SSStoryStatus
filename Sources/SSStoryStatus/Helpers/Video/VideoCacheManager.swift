//
//  VideoCacheManager.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 01/11/23.
//

import AVKit

// MARK: - Video Cache Manager
class VideoCacheManager {
    
    // MARK: - Vars & Lets
    private let fileManager = FileManager.default
    private let videoRetriever = VideoRetriever.shared
    
    private lazy var cacheDirectoryURL = {
        let url = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: Paths.cacheDirectoryName)
            .appending(path: Paths.videoCacheDirectoryName)
        return url
    }()
    
    // MARK: - Methods
    func getVideo(for remoteUrl: URL) -> URL? {
        let fileURL = getFileUrl(for: remoteUrl.md5String)
        
        guard fileManager.fileExists(atPath: fileURL.path()) else {
            return nil
        }
        
        return fileURL
    }
    
    func saveVideo(avAsset: AVAsset, remoteUrl: URL, date: Date = .now) async throws -> URL {
        let fileURL = getFileUrl(for: remoteUrl.md5String)
        
        try await videoRetriever.exportVideo(avAsset: avAsset, outputURL: fileURL)
        try setCreationDate(for: fileURL.path(), date: date)
        return fileURL
    }
    
    func clearCache(olderThan date: Date) {
        fileManager.clearCache(directory: cacheDirectoryURL, olderThan: date)
    }
    
    func clearAll() {
        try? fileManager.removeItem(at: cacheDirectoryURL)
    }
    
    private func getFileUrl(for fileName: String, fileExtension: String = "mp4") -> URL {
        createFolderIfNeeded()
        
        return cacheDirectoryURL.appending(path: fileName).appendingPathExtension(fileExtension)
    }
    
    private func createFolderIfNeeded() {
        guard !fileManager.fileExists(atPath: cacheDirectoryURL.path()) else { return }
        
        try? fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true)
    }
    
    private func setCreationDate(for path: String, date: Date) throws {
        try fileManager.setAttributes([.creationDate: date], ofItemAtPath: path)
    }
    
    // MARK: - Shared Instance
    static let shared = VideoCacheManager()
    
    // MARK: - Private Initializer
    private init() { }
}
