//
//  AsyncVideoModel.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 01/11/23.
//

import Observation
import AVKit
import Combine

@Observable
class VideoModel {
    
    // MARK: - Vars & Lets
    var videoState: VideoState = .loading
    var duration: Double = Double(Durations.storyDefaultDuration)
    var progress: Double = 0
    let videoCacheManager = VideoCacheManager.shared
    var url: URL?
    var player: AVPlayer = AVPlayer()
    private var playerTimeObserver: Any? = nil
    
    // MARK: - Methods
    func fetchVideo(url: URL?, date: Date) async {
        
        guard let url else {
          videoState = .error(.invalidURL)
            return
        }
        
        let newMedia = self.url != url
        
        if !newMedia {
            updatePlayer(forced: false)
            return
        }
        
        self.url = url
        Task {
            await fetchDuration()
        }
        
        guard let avAsset = getAVAsset() else {
            videoState = .error(.invalidURL)
            return
        }
        
        if let cacheURL = videoCacheManager.getVideo(for: url) {
            videoState = .success(cacheURL)
        } else {
            videoState = .success(url)
            
            
            do {
                _ = try await videoCacheManager.saveVideo(avAsset: avAsset, remoteUrl: url, date: date)
            } catch { }
        }
        
        updatePlayer()
    }
    
    func fetchDuration() async {
        guard let avAsset = getAVAsset() else {
            duration = 0
            return
        }
        
        let cmTime = try? await avAsset.load(.duration)
        duration = CMTimeGetSeconds(cmTime ?? .zero)
    }
    
    func updatePlayer(forced: Bool = true) {
        
        switch videoState {
        case .success(let url):
            if forced || player.currentTime() >= player.currentItem?.duration ?? .zero {
                removePlayerObserver()
                player.replaceCurrentItem(with: AVPlayerItem(url: url))
                setupPlayerObserver()
            }
        default:
            resetPlayer()
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
        playerTimeObserver = nil
    }
    
    func pausePlayback() {
        player.pause()
    }
    
    func resumePlayback() {
        player.play()
    }
    
    func resetPlayer() {
        removePlayerObserver()
        player.replaceCurrentItem(with: nil)
        self.url = nil
    }
    
    private func getAVAsset() -> AVAsset? {
        guard let url else {
            return nil
        }
        return AVAsset(url: url)
    }
}

// MARK: - Enums
extension VideoModel {
    
    // MARK: - VideoState
    enum VideoState {
        case loading
        case success(URL)
        case error(VideoError)
    }
    
    // MARK: - VideoError
    enum VideoError: Error {
        case invalidURL
    }
}
