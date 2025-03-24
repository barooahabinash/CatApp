//
//  CatBreedsModel.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import Foundation

struct CatBreedsModel: Identifiable, Decodable, Equatable {
    let id: String
    let name: String
    let description: String
    let origin: String
    let temperament: String
    let image: CatImage?
    
    static func == (lhs: CatBreedsModel, rhs: CatBreedsModel) -> Bool {
            return lhs.id == rhs.id
        }
}

struct CatImage: Decodable {
    let url: String
}
