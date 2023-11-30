//
//  AsyncImageModel.swift
//
//
//  Created by Krunal Patel on 31/10/23.
//

import UIKit
import Combine

@Observable
class AsyncImageModel: ObservableObject {
    
    // MARK: - Vars & Lets
    @ObservationIgnored private let cacheManager = ImageCacheManager.shared
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []
    var imageUrl: URL?
    var imageState: ImageState = .loading
    
    // MARK: - Private Methods
    private func getImage() {
        guard let imageUrl else {
            imageState = .error(.invalidUrl)
            return
        }
        
        if let cacheImage = cacheManager.getImage(for: imageUrl) {
            imageState = .success(cacheImage)
        } else {
            downloadAndCacheImage()
        }
    }
    
    private func downloadAndCacheImage() {
        guard let imageUrl else {
            imageState = .error(.invalidUrl)
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: imageUrl)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .tryMap(decodeImage)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                guard let self, let image else { return }
                
                self.imageState = .success(image)
                self.cacheManager.addImage(image: image, url: imageUrl)
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
    
    // MARK: - Initializers
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
        getImage()
    }
    
    init(imageUrl: String) {
        self.imageUrl = URL(string: imageUrl)
        getImage()
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
