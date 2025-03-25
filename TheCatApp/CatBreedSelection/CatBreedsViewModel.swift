//
//  CatBreedsViewModel.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import Foundation

class CatBreedsViewModel: ObservableObject {
    @Published var breeds: [CatBreedsModel] = []
    
    private var currentPage = 1
    private let breedsPerPage = 10
    private let service: CatServiceProtocol
    
    init(service: CatServiceProtocol = CatService()) {
        self.service = service
        //Code to clear cache if needed
        //NetworkCacheManager.shared.clearCache()
    }
    
    func fetchBreeds() {
        Task {
            do {
                
                let fetchedbreeds = try await service.fetchBreeds(limit: breedsPerPage, page: currentPage)
                await MainActor.run{
                    self.breeds.append(contentsOf: fetchedbreeds)
                    self.currentPage += 1
                }
            } catch {
                print("Error fetching breeds: \(error)")
                await MainActor.run{
                }
            }
        }
    }

}
