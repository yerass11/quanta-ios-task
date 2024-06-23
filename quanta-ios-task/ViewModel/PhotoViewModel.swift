//
//  PhotoViewModel.swift
//  quanta-ios-task
//
//  Created by Yerasyl on 22.06.2024.
//

import SwiftUI
import Combine
import SDWebImage

class PhotoViewModel: ObservableObject {
    @Published var photos = [Photo]()
    @Published var searchText = ""
    @Published var isLoading = false
    private var cancellable: AnyCancellable?
    private var currentPage = 1
    private let pageSize = 30
    
    init() {
        loadPhotos()
    }
    
    func loadPhotos(reset: Bool = false) {
        if reset {
            photos.removeAll()
            currentPage = 1
        }
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_page=\(currentPage)&_limit=\(pageSize)") else { return }
        
        isLoading = true
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newPhotos in
                self?.photos.append(contentsOf: newPhotos)
                self?.currentPage += 1
                self?.isLoading = false
            }
    }
    
    var filteredPhotos: [Photo] {
        if searchText.isEmpty {
            return photos
        } else {
            return photos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}



