//
//  Photo.swift
//  quanta-ios-task
//
//  Created by Yerasyl on 22.06.2024.
//

import Foundation

struct Photo: Identifiable, Decodable, Equatable {
    let id: Int
    let title: String
    let url: String
}
