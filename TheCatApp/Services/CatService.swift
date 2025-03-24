//
//  CatService.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import Foundation

protocol CatServiceProtocol {
    func fetchBreeds(limit: Int, page: Int) async throws -> [CatBreedsModel]
    func fetchBreedImages(breedId: String) async throws -> [BreedImagesModel]
}

// MARK: - Service Implementation
class CatService: CatServiceProtocol {
        
    func fetchBreeds(limit: Int, page: Int) async throws -> [CatBreedsModel] {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=\(limit)&page=\(page)") else {
            throw URLError(.badURL)
        }
        let apiKey = "live_MtjaYf3PndTb8hqHKda8VjDhdyxlxMOqYWmb3ChZCLNTq6MXc0ZFScAUuCT4SaTM"
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.cachePolicy = .returnCacheDataElseLoad
        
        // Check if cached response exists
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            print(cachedResponse.data)
            return try JSONDecoder().decode([CatBreedsModel].self, from: cachedResponse.data)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        
        let cachedResponse = CachedURLResponse(response: urlResponse, data: data)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        return try JSONDecoder().decode([CatBreedsModel].self, from: data)
    }
    
    func fetchBreedImages(breedId: String) async throws -> [BreedImagesModel] {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&breed_ids=\(breedId)") else {
            throw URLError(.badURL)
        }
        
        let apiKey = "live_MtjaYf3PndTb8hqHKda8VjDhdyxlxMOqYWmb3ChZCLNTq6MXc0ZFScAUuCT4SaTM"
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.cachePolicy = .returnCacheDataElseLoad
        
        // Check if cached response exists
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return try JSONDecoder().decode([BreedImagesModel].self, from: cachedResponse.data)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        
        let cachedResponse = CachedURLResponse(response: urlResponse, data: data)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        return try JSONDecoder().decode([BreedImagesModel].self, from: data)
    }
}

