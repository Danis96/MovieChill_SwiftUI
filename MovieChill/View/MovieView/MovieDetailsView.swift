//
//  MovieDetailsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 25. 6. 2024..
//

import SwiftUI

struct MovieDetailsView: View {
    
    @EnvironmentObject private var movieVM: MovieViewModel
    let movie: Movie
    
    var body: some View {
        VStack {
            
            if movieVM.isLoadingDetails {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                imageSection
                Text("\(movie.title)")
            }
        }
    }
}

extension MovieDetailsView {
    private var imageSection: some View {
        TabView {
            if let images = movie.detailsImageList {
                ForEach(images.indices, id: \.self) { index in
                    images[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                        .clipped()
                }
            }
            
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    TopTabsView()
        .environmentObject(DeveloperPreview.instance.tabsViewModel)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
}
