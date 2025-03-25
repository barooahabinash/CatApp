//
//  NetworkCacheManager.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 25/03/2025.
//

import Foundation

class NetworkCacheManager {
    static let shared = NetworkCacheManager()

    private let cache: URLCache

    private init() {
        let memoryCapacity = 50 * 1024 * 1024 // 50MB memory cache
        let diskCapacity = 100 * 1024 * 1024 // 100MB disk cache
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cachePath = cacheDirectory.appendingPathComponent("URLCache")
        
        self.cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, directory: cachePath)
        URLCache.shared = self.cache 
    }

    // Store Response in Cache
    func storeResponse(_ response: URLResponse, data: Data, for request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
    }

    // Retrieve Cached Response
    func getCachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return cache.cachedResponse(for: request)
    }
    //Clear Cache
    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }
}

