//
//  AsyncVideoModel.swift
//
//
//  Created by Krunal Patel on 01/11/23.
//

import Observation
import AVKit
import Combine

@Observable
class VideoModel {
    
    // MARK: - Vars & Lets
    var videoState: VideoState = .loading {
        didSet {
            updatePlayer()
        }
    }
    @ObservationIgnored var duration: Double = 0
    var progress: Double = 0
    @ObservationIgnored let videoCacheManager = VideoCacheManager.shared
    @ObservationIgnored let id: String
    @ObservationIgnored let url: URL?
    @ObservationIgnored private let extention = ".mp4"
    private var fileName: String {
        id + extention
    }
    @ObservationIgnored var player: AVPlayer = AVPlayer()
    private var playerTimeObserver: Any? = nil
    
    // MARK: - Methods
    func fetchVideo() async {
        guard let url,
              let avAsset = getAVAsset() else {
            videoState = .error(.invalidURL)
            return
        }
        
        if let cacheURL = videoCacheManager.getVideo(for: fileName) {
            videoState = .success(cacheURL)
            return
        } else {
            videoState = .success(url)
        }
        
        do {
            try await videoCacheManager.saveVideo(avAsset: avAsset, fileName: fileName)
        } catch { }
    }
    
    func fetchDuration() async {
        guard let avAsset = getAVAsset() else {
            duration = 0
            return
        }
        
        let cmTime = try? await avAsset.load(.duration)
        duration = CMTimeGetSeconds(cmTime ?? .zero)
    }
    
    func updatePlayer() {
        removePlayerObserver()
        switch videoState {
        case .success(let url):
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
            setupPlayerObserver()
        default:
            duration = 0
            player.replaceCurrentItem(with: nil)
        }
    }
    
    func setupPlayerObserver() {
        let interval = CMTime(seconds: Durations.videoProgressUpdateInterval, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        playerTimeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] cmTime in
            self?.progress = CMTimeGetSeconds(cmTime)
        }
    }
    
    func removePlayerObserver() {
        if let playerTimeObserver {
            player.removeTimeObserver(playerTimeObserver)
        }
    }
    
    func pausePlayback() {
        player.pause()
    }
    
    func resumePlayback() {
        player.play()
    }
    
    private func getAVAsset() -> AVAsset? {
        guard let url else {
            return nil
        }
        return AVAsset(url: url)
    }
    
    // MARK: - Initializer
    init(id: String, url: URL?) {
        self.id = id
        self.url = url
    }
}

// MARK: - VideoState
extension VideoModel {
    
    enum VideoState {
        case loading
        case success(URL)
        case error(VideoError)
    }
}

// MARK: - VideoError
extension VideoModel {
    
    enum VideoError: Error {
        case invalidURL
    }
}
