//
//  AsyncImageView.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    let placeholder: Image
    
    init(urlString: String?, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
        self.placeholder = placeholder
    }
    
    var body: some View {
        // If image exists
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else { // if no image
            placeholder
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}
