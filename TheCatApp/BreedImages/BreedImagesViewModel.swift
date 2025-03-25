//
//  BreedImagesViewModel.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 22/03/2025.
//

import Foundation

class BreedImagesViewModel: ObservableObject {
    @Published var images: [BreedImagesModel] = []

    private let service: CatServiceProtocol
    
    init(service: CatServiceProtocol = CatService()) {
        self.service = service
    }
    
    func fetchImages(for breedId: String) {
        Task {
            do {
                let fetchedImages = try await service.fetchBreedImages(breedId: breedId)
                await MainActor.run{
                    self.images = fetchedImages
                }
            } catch {
                print("Error fetching breed images: \(error)")
            }
        }
    }
}
