//
//  TVShowDetailsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI


struct TVShowDetailsView: View {
    
    @EnvironmentObject private var tvShowVM: TVShowsViewModel
    let tvShow: TVModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                imageSection
                
                infoText
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Overview")
                        .font(.headline)
                    Text(tvShow.overview)
                }
                .padding()
                
            }.overlay(alignment: .topLeading) {
                xMarkButton
            }
        }.ignoresSafeArea()
        
    }
}

extension TVShowDetailsView {
    private var imageSection: some View {
        TabView {
            if let images = tvShow.detailsImageList {
                ForEach(images.indices, id: \.self) { index in
                    images[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                        .clipped()
                        .shadow(radius: 10)
                }
            }
            
        }
        .frame(height: 550)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var xMarkButton: some View {
        Button(action: {
            tvShowVM.tvShowSheet = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.title2)
                .foregroundStyle(.black)
                .frame(width: 45, height: 45)
                .background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(26)
        })
    }
    
    private var infoText: some View {
        VStack(alignment: .leading) {
            Text("\(tvShow.name)")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack {
                Text(tvShow.voteAverage.asNumberString())
                    .font(.headline)
                Image(systemName: "hands.clap")
            }
            
            Text("First air date: \(tvShow.firstAirDate.formatDateString())")
                .font(.subheadline)
            
        }.padding()
    }
}

#Preview {
    MovieDetailsView(movie: DeveloperPreview.instance.movie)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
}
