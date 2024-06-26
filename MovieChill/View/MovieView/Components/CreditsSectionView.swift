//
//  CreditsSectionView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI

struct CreditsSectionView: View {
    
    @EnvironmentObject private var movieVM: MovieViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(movieVM.movieCredits) { cast in
                VStack {
                    
                    imageSection(cast: cast)
                    if let character = cast.character {
                        Text(character)
                    }
                    
                    Divider()
                    Text(cast.name)
                        .font(.headline)
                    
                }
                .frame(height: 240)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .shadow(radius: 10)
                    
                )
                .cornerRadius(8)
                
                
                
            }
        }.padding()
    }
}

extension CreditsSectionView {
    
    private func imageSection(cast: Cast) -> some View {
        
        return VStack {
            if let image = cast.imageData {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140)
                    .clipped()
            }
        }
    }
    
}

#Preview {
    CreditsSectionView()
        .environmentObject(DeveloperPreview.instance.movieViewModel)
}
