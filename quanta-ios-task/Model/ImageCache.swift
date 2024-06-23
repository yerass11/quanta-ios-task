//
//  ImageCache.swift
//  quanta-ios-task
//
//  Created by Yerasyl on 22.06.2024.
//

import SwiftUI

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
    
    private init() {}
}
