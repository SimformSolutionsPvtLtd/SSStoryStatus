//
//  VideoRetriever.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 01/11/23.
//

import AVKit

class VideoRetriever {
    
    // MARK: - Methods
    func exportVideo(avAsset: AVAsset, outputURL: URL, fileType: AVFileType = .mp4, preset: String = AVAssetExportPresetHighestQuality) async throws {
        guard let exportable = try? await avAsset.load(.isExportable), exportable else {
            throw RetrieverError.notExportable
        }
        
        let composition = try await getMutableComposition(avAsset: avAsset)
        
        guard await AVAssetExportSession.compatibility(ofExportPreset: preset, with: composition, outputFileType: fileType) else {
            throw RetrieverError.incompatibleFile
        }
        
        guard let session = AVAssetExportSession(asset: composition, presetName: preset) else {
            throw RetrieverError.unknownError
        }
        
        session.outputURL = outputURL
        session.outputFileType = fileType
        
        await session.export()
        
        guard session.status == .completed else {
            throw RetrieverError.exportFailed(session.error?.localizedDescription)
        }
    }
    
    private func getMutableComposition(avAsset: AVAsset) async throws -> AVMutableComposition {
        guard let sourceVideoTrack = try await avAsset.loadTracks(withMediaType: .video).first,
              let sourceAudioTrack = try await avAsset.loadTracks(withMediaType: .audio).first else {
            throw RetrieverError.notExportable
        }
        
        let composition = AVMutableComposition()
        guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)),
              let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)) else {
            throw RetrieverError.notExportable
        }
        
        // Insert audio & video
        do {
            let timeRange = try await CMTimeRange(start: .zero, end: avAsset.load(.duration))
            try compositionAudioTrack.insertTimeRange(timeRange, of: sourceAudioTrack, at: .zero)
            try compositionVideoTrack.insertTimeRange(timeRange, of: sourceVideoTrack, at: .zero)
        } catch {
            throw RetrieverError.notExportable
        }
        
        return composition
    }
    
    // MARK: - Shared Instance
    static let shared = VideoRetriever()
    
    // MARK: - Private Initializer
    private init() { }
}

// MARK: - Enums
extension VideoRetriever {
    
    // MARK: - RetrieverErrors
    enum RetrieverError: Error {
        case invalidURL
        case notExportable
        case incompatibleFile
        case exportFailed(String?)
        case unknownError
    }
}
