//
//  ItemCardView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI

struct ItemCardView: View {
    
    let image: Image
    let currentIndex: Int
    let index: Int
    let geometry: GeometryProxy
    var onTapPressed: () async -> Void
    let title: String
    let voteAverage: String
    let genreIDS: [Int]
    
    var body: some View {
        VStack(spacing: 40) {
           
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 200, height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 15)
            
            movieTextPoster
        }
        .frame(width: geometry.size.width)
        .scaleEffect(currentIndex == index ? 1.0 : 0.8)
        .opacity(currentIndex == index ? 1.0 : 0.0)
        .animation(.easeInOut(duration: 0.5), value: currentIndex)
        .onTapGesture {
            Task {
                await onTapPressed()
            }
        }
    }
}

extension ItemCardView {

    func returnGenreName(genreID: Int) -> String {
        let constants = MovieChillConstants()
        for genre in constants.genres {
            if(genreID == genre.id) {
                return "\(genre.name) /"
            }
        }
        return ""
    }

    private var movieTextPoster: some View {
    VStack(alignment: .center, spacing: 10) {
        if currentIndex == index {
            Text(title)
                .frame(maxWidth: UIScreen.main.bounds.width / 1.2)
                .font(.title)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            
            HStack {
                ForEach(genreIDS.prefix(3), id: \.self) { genreID in
                    Text("\(returnGenreName(genreID: genreID))")
                        .font(.caption)
                }
            }
            
            HStack(alignment: .center) {
                Text(voteAverage)
                    .font(.title)
                    
                Image(systemName: "hands.clap.fill")
            }
        }
    }.foregroundStyle(Color("TextColor"))
}
}
