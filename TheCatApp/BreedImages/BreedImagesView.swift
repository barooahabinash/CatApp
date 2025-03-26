//
//  BreedImagesView.swift
//  TheCatApp
//
//  Created by Abinash Barooah on 22/03/2025.
//

import SwiftUI

struct BreedImagesView: View {
    @StateObject private var breedImagesModel = BreedImagesViewModel()
    let breedId: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(breedImagesModel.images) { image in
                    if let url = URL(string: image.url) {
                        GeometryReader { geometry in
                            let screenWidth = UIScreen.main.bounds.width
                            let position = geometry.frame(in: .global).midX
                            let center = screenWidth / 2
                            let scale = max(0.8, 1.5 - abs(position - center) / screenWidth)
                            
                            AsyncImage(url: url) { breedImage in
                                switch breedImage {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 250, height: 250)
                                case .success(let image):image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 250, height: 250)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .scaleEffect(scale)
                                        .animation(.easeInOut(duration: 0.3), value: scale)
                                case .failure:
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 250, height: 250)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        .frame(width: 250, height: 250)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .onChange(of: breedId, initial: true) { breedId, newBreedId in
            breedImagesModel.fetchImages(for: newBreedId)
            }
    }
}

#Preview {
    BreedImagesView(breedId: "abys")
}

