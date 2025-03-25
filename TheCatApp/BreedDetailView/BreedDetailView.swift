//
//  BreedDetailView.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 25/03/2025.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: CatBreedsModel


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                BreedImagesView(breedId: breed.id)
                    .frame(height: 280)
                
                
                Text("Origin: \(breed.origin)")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text("Temperament: \(breed.temperament)")
                    .font(.title3)
                    .padding(.top, 5)
                
                Text(breed.description)
                    .font(.title3)
                    .padding(.top, 5)
                
            }
            .padding()
        }
        .navigationTitle(breed.name)
    }
}

