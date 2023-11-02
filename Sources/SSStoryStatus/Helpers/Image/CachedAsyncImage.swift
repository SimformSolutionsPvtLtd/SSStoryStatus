//
//  CachedAsyncImage.swift
//
//
//  Created by Krunal Patel on 31/10/23.
//

import SwiftUI
import Combine

struct CachedAsyncImage<Content: View>: View {
    
    // MARK: - Vars & Lets
    private let imageModel: AsyncImageModel
    @ViewBuilder let content: (AsyncImagePhase) -> Content
    
    // MARK: - Body
    var body: some View {
        switch imageModel.imageState {
        case .loading:
            content(.empty)
        case .success(let image):
            content(.success(Image(uiImage: image)))
        case .error(let error):
            content(.failure(error))
        }
    }
    
    // MARK: - Initializer
    init(imageModel: AsyncImageModel, @ViewBuilder _ content: @escaping (_ phase: AsyncImagePhase) -> Content) {
        self.imageModel = imageModel
        self.content = content
    }
}
