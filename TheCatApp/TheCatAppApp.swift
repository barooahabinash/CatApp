//
//  TheCatAppApp.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import SwiftUI

@main
struct TheCatAppApp: App {
    
    init() {
            let memoryCapacity = 50 * 1024 * 1024 // 50MB
            let diskCapacity = 100 * 1024 * 1024 // 100MB
            let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "catCache")
            URLCache.shared = cache
        }
    
    var body: some Scene {
        WindowGroup {
            CatBreedsView()
        }
    }
}
