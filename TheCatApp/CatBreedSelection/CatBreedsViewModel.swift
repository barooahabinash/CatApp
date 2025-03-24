//
//  CatBreedsViewModel.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import Foundation

class CatBreedsViewModel: ObservableObject {
    @Published var breeds: [CatBreedsModel] = []
    @Published var isLoading = false
    
    private var currentPage = 1
    private let breedsPerPage = 10
    private let service: CatServiceProtocol
    
    init(service: CatServiceProtocol = CatService()) {
        self.service = service
    }
    
    func fetchBreeds() {
        Task {
            do {
                
                let fetchedbreeds = try await service.fetchBreeds(limit: breedsPerPage, page: currentPage)
                await MainActor.run{
                    self.breeds.append(contentsOf: fetchedbreeds)
                    self.currentPage += 1
                    self.isLoading = false
                   // self.breeds = fetchedbreeds
                    //print(self.breeds)
                }
            } catch {
                print("Error fetching breeds: \(error)")
                await MainActor.run{
                    self.isLoading = false
                }
            }
        }
    }

}
