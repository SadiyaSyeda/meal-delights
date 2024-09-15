//
//  ImageLoader.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        // Check if the image exists in cache
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        // If image not found in cache, fetch from the network
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    // Cache the image
                    ImageCache.shared.setImage(uiImage, forKey: urlString)
                    DispatchQueue.main.async {
                        self.image = uiImage
                    }
                }
            } catch {
                print("Failed to load image from URL: \(error)")
            }
        }
    }
}
