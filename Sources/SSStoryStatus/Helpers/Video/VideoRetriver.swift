//
//  VideoRetriver.swift
//
//
//  Created by Krunal Patel on 01/11/23.
//

import AVKit

class VideoRetriver {
    
    // MARK: - Methods
    func exportVideo(avAsset: AVAsset, outputURL: URL, fileType: AVFileType = .mp4, preset: String = AVAssetExportPresetHighestQuality) async throws {
        guard let exportable = try? await avAsset.load(.isExportable), exportable else {
            throw RetriverError.notExportable
        }
        
        let composition = try await getMutableComposition(avAsset: avAsset)
        
        guard await AVAssetExportSession.compatibility(ofExportPreset: preset, with: composition, outputFileType: fileType) else {
            throw RetriverError.incompatibleFile
        }
        
        guard let session = AVAssetExportSession(asset: composition, presetName: preset) else {
            throw RetriverError.unknownError
        }
        
        session.outputURL = outputURL
        session.outputFileType = fileType
        
        await session.export()
        
        guard session.status == .completed else {
            throw RetriverError.exportFailed(session.error?.localizedDescription)
        }
    }
    
    private func getMutableComposition(avAsset: AVAsset) async throws -> AVMutableComposition {
        guard let sourceVideoTrack = try await avAsset.loadTracks(withMediaType: .video).first,
              let sourceAudioTrack = try await avAsset.loadTracks(withMediaType: .audio).first else {
            throw RetriverError.notExportable
        }
        
        let composition = AVMutableComposition()
        guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)),
              let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)) else {
            throw RetriverError.notExportable
        }
        
        // Insert audio & video
        do {
            let timeRange = try await CMTimeRange(start: .zero, end: avAsset.load(.duration))
            try compositionAudioTrack.insertTimeRange(timeRange, of: sourceAudioTrack, at: .zero)
            try compositionVideoTrack.insertTimeRange(timeRange, of: sourceVideoTrack, at: .zero)
        } catch {
            throw RetriverError.notExportable
        }
        
        return composition
    }
    
    // MARK: - Shared Instance
    static let shared = VideoRetriver()
    
    // MARK: - Private Initializer
    private init() { }
}

// MARK: - Retriver Errors
extension VideoRetriver {
    
    enum RetriverError: Error {
        case invalidURL
        case notExportable
        case incompatibleFile
        case exportFailed(String?)
        case unknownError
    }
}
