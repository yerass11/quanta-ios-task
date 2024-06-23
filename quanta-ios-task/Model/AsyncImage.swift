//
//  AsyncImage.swift
//  quanta-ios-task
//
//  Created by Yerasyl on 22.06.2024.
//

import SwiftUI

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    var placeholder: Image
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }
    
    var body: some View {
        image
            .onAppear(perform: loader.load)
    }
    
    private var image: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
