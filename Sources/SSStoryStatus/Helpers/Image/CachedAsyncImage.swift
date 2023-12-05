//
//  CachedAsyncImage.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 31/10/23.
//

import SwiftUI
import Combine

/// A view that caches and loads image asynchronously.
///
/// You can use `CachedAsyncImage` with ``init(imageModel:_:)`` by passing
/// ``AsyncImageModel`` and providing view builder for different image phases.
///
/// ```swift
/// struct MyView: View {
///     @State var imageModel = AsyncImageModel()
///
///     var body: some View {
///         CachedAsyncImage(imageModel: imageModel) { phase in
///             switch phase {
///             case .success(let image):
///                 image // Use image modifiers here.
///             case .failure(_):
///                 Image(systemName: "ant.circle.fill") // When image fails to load.
///             case .empty:
///                 Image(systemName: "photo.circle.fill") // When image is loading.
///             @unknown default:
///                 Image(systemName: "photo.circle.fill")
///             }
///         }
///         .onAppear {
///             imageModel.enableResizing(size: CGSize(width: 300, height: 300)) // Provide size for resizing to enhance performance.
///             imageModel.getImage(url: URL(string: "https://loremflickr.com/320/240/dog"), type: .profile) // URL for image and type of image.
///         }
///     }
/// }
/// ```
///
/// > Important: You can't apply image-specific modifiers, like
/// ``Image/resizable(capInsets:resizingMode:)``, directly to an `CachedAsyncImage`.
/// Instead, apply them to the `Image` instance that your `content`
/// closure gets when defining the view's appearance.
public struct CachedAsyncImage<Content: View>: View {
    
    // MARK: - Vars & Lets
    private let imageModel: AsyncImageModel
    @ViewBuilder let content: (AsyncImagePhase) -> Content
    
    // MARK: - Body
    public var body: some View {
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
    /// Create and load asynchronous image view.
    ///
    /// - Parameters:
    ///   - imageModel: The asynchronous image model.
    ///   - content: View builder for content according to image phase.
    public init(imageModel: AsyncImageModel, @ViewBuilder _ content: @escaping (_ phase: AsyncImagePhase) -> Content) {
        self.imageModel = imageModel
        self.content = content
    }
}
