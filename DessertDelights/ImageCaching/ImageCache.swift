//
//  ImageCache.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private init() { }
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
