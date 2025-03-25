//
//  CatBreedsView.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import SwiftUI

struct CatBreedsView: View {
    @StateObject var catBreedsModel = CatBreedsViewModel()
        
    var body: some View {
        NavigationSplitView {
            List(catBreedsModel.breeds) { breed in
                NavigationLink(destination: BreedDetailView(breed: breed)) {
                    BreedRowView(breed: breed)
                }
                .onAppear{
                    if breed == catBreedsModel.breeds.last{
                        catBreedsModel.fetchBreeds()
                    }
                }
            }
            .navigationTitle("Cat Breeds")
            .onAppear {
                catBreedsModel.fetchBreeds()
            }
        }
        detail: {
                Text("All about cats 😎 Please select a breed") // Default placeholder when no breed is selected
                    .font(.title)
                    .foregroundColor(.gray)
            }
    }
}

struct BreedRowView: View {
    let breed: CatBreedsModel
        
    var body: some View {
        HStack {
            if let imageUrl = breed.image?.url, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
            }
            VStack(alignment: .leading) {
                Text(breed.name)
                    .font(.headline)
                Text(breed.origin)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    CatBreedsView()
}
