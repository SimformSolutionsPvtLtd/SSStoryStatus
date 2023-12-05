//
//  CachedAsyncVideo.swift
//
//
//  Created by Krunal Patel on 01/11/23.
//

import SwiftUI
import AVKit

struct CachedAsyncVideo<Content: View>: View {
    
    // MARK: - Vars & Lets
    @State var videoModel: VideoModel
    var isPaused: Bool
    @ViewBuilder let content: (AsyncVideoPhase) -> Content
    var onProgressChange: ProgressType? = nil
    
    // MARK: - Body
    var body: some View {
        ZStack {
            switch videoModel.videoState {
            case .loading:
                content(.empty)
            case .success(let url):
                content(.success(getVideoPlayer(url: url)))
            case .error(let error):
                content(.failure(error))
            }
        }
        .task(priority: .userInitiated) {
            await videoModel.fetchVideo()
        }
        .task(priority: .userInitiated) {
            await videoModel.fetchDuration()
        }
        .onChange(of: videoModel.progress) { _, progress in
            if progress <= videoModel.duration {
                onProgressChange?(progress, videoModel.duration)
            }
        }
        .onChange(of: isPaused, initial: true) { _, newValue in
            if newValue {
                videoModel.pausePlayback()
            } else {
                videoModel.resumePlayback()
            }
        }
    }
    
    // MARK: - Initializer
    init(id: String, url: URL?, isPaused: Bool, @ViewBuilder _ content: @escaping (_ phase: AsyncVideoPhase) -> Content) {
        _videoModel = State(wrappedValue: VideoModel(id: id, url: url))
        self.content = content
        self.isPaused = isPaused
    }
}

// MARK: - Private Functions
extension CachedAsyncVideo {
    
    @ViewBuilder
    private func getVideoPlayer(url: URL) -> VideoPlayer<EmptyView> {
        VideoPlayer(player: videoModel.player)
    }
}

// MARK: - Modifiers
extension CachedAsyncVideo {
    typealias ProgressType = (_ progress: Double, _ totalDuration: Double) -> Void
    
    func onProgressChange(perform action: @escaping ProgressType) -> Self {
        var copy = self
        copy.onProgressChange = action
        return copy
    }
}

// MARK: - AsyncVideoPhase
enum AsyncVideoPhase {
    case empty
    case success(VideoPlayer<EmptyView>)
    case failure(Error)
}
