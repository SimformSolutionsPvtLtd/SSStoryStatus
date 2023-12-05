//
//  AsyncImageModel.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 31/10/23.
//

import UIKit
import Combine

@Observable
public class AsyncImageModel: ObservableObject {
    
    // MARK: - Vars & Lets
    var imageState: ImageState = .loading
    @ObservationIgnored private let cacheManager = ImageCacheManager.shared
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []
    @ObservationIgnored var size: CGSize? = nil
    @ObservationIgnored var shouldResizeProfile = true
    @ObservationIgnored var url: URL?
    
    // MARK: - Methods
    func getImage(url: URL?, type: ImageType) {
        guard !isURLSame(url) else { return }
        
        imageState = .loading
        guard let url else {
            imageState = .error(.invalidUrl)
            return
        }
        self.url = url
        
        if let cacheImage = cacheManager.getImage(for: url, type: type) {
            setImage(cacheImage)
        } else {
            downloadAndCacheImage(url: url, type: type)
        }
    }
    
    func enableResizing(size: CGSize) {
        self.size = size
    }
    
    func disableResizing() {
        size = nil
    }
    
    private func setImage(_ image: UIImage) {
        var newImage = image
        if let size,
           let resizedImage = image.preparingThumbnail(of: size) {
            newImage = resizedImage
        }
        imageState = .success(newImage)
    }
    
    private func isURLSame(_ newUrl: URL?) -> Bool {
        return url == newUrl
    }
    
    private func downloadAndCacheImage(url: URL?, type: ImageType) {
        guard let url else {
            imageState = .error(.invalidUrl)
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .tryMap(decodeImage)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                guard let self, let image else { return }
                
                self.setImage(image)
                self.cacheManager.addImage(image: image, url: url, type: type)
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 299 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
    private func decodeImage(data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            imageState = .error(.decodingError)
            return nil
        }
        return image
    }
}

// MARK: - Enums
// MARK: - Image Error
enum ImageError: Error {
    case invalidUrl
    case decodingError
    case unknownError
}

// MARK: - Image State
enum ImageState {
    case loading
    case success(UIImage)
    case error(ImageError)
}
