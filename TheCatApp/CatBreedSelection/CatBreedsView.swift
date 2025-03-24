//
//  CatBreedsView.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 21/03/2025.
//

import SwiftUI

struct CatBreedsView: View {
    @StateObject var viewModel = CatBreedsViewModel()
        
        var body: some View {
            NavigationView {
                List(viewModel.breeds) { breed in
                    NavigationLink(destination: BreedDetailView(breed: breed)) {
                        BreedRowView(breed: breed)
                    }
                    .onAppear{
                        if breed == viewModel.breeds.last{
                            viewModel.fetchBreeds()
                        }
                    }
                }
                .navigationTitle("Cat Breeds")
                .onAppear {
                    viewModel.fetchBreeds()
                }
            }
        }
    }

    struct BreedRowView: View {
        let breed: CatBreedsModel
        
        var body: some View {
            HStack {
                if let imageUrl = breed.image?.url, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                             .scaledToFill()
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

struct BreedDetailView: View {
    let breed: CatBreedsModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                BreedImagesView(breedId: breed.id)
                
//                Text(breed.name)
//                    .font(.largeTitle)
//                    .bold()
                
                Text("Origin: \(breed.origin)")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text("Temperament: \(breed.temperament)")
                    .padding(.top, 5)
                
                Text(breed.description)
                    .padding(.top, 5)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(breed.name)
    }
}


#Preview {
    CatBreedsView()
}
