//
//  CatBreedDetailViewModel.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 22/03/2025.
//

import Foundation

@MainActor
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
                    //print(self.images)
                }
            } catch {
                print("Error fetching breed images: \(error)")
            }
        }
    }
    
        
//    func fetchMoreImages(breedId: String) {
//        guard !isLoading else { return }
//        isLoading = true
//            
//        Task {
//            do {
//                let newImages = try await service.fetchBreedImages(breedId: breedId, page: currentPage, limit: pageSize)
//                DispatchQueue.main.async {
//                    self.images.append(contentsOf: newImages)
//                    self.currentPage += 1
//                    self.isLoading = false
//                }
//            } catch {
//                print("Error fetching images: \(error)")
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    }
//            }
//        }
//    }
}
