//
//  CatBreedDetailView.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 22/03/2025.
//

import SwiftUI

struct BreedImagesView: View {
    @StateObject private var viewModel = BreedImagesViewModel()
    let breedId: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.images) { image in
                    if let url = URL(string: image.url) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchImages(for: breedId)
            //viewModel.fetchMoreImages(breedId: breedId)
        }
    }
    
//    var body: some View {
//            ScrollView {
//                LazyVStack {
//                    ForEach(viewModel.images, id: \.id) { image in
//                        AsyncImage(url: URL(string: image.url)) { img in
//                            img.resizable()
//                               .scaledToFit()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                    }
//                    
//                    // Show a loading indicator when fetching more images
//                    if viewModel.isLoading {
//                        ProgressView()
//                            .padding()
//                    }
//
//                    // Trigger loading more images when reaching the last item
//                    if let lastImage = viewModel.images.last {
//                        Color.clear
//                            .onAppear {
//                                viewModel.fetchMoreImages(breedId: breedId)
//                            }
//                    }
//                }
//            }
//            .onAppear {
//                viewModel.fetchMoreImages(breedId: breedId)
//            }
//        }
}

