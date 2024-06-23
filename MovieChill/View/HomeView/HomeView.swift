//
//  HomeView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var movieVM: MovieViewModel
    
    let movies: [Movie]
    
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
            VStack {
                movieScrollView
            }
    }
}


extension HomeView {
    
    private var movieScrollView: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width - 20 // 20 padding on each side
            let spacing: CGFloat = 20
            let totalSpacing = (spacing * CGFloat(movies.count - 1))
            let contentWidth = (cardWidth * CGFloat(movies.count)) + totalSpacing
            let offset = CGFloat(currentIndex) * -cardWidth + dragOffset
            
            HStack(spacing: spacing) {
                ForEach(movies) { movie in
                    moviePosterView(movie: movie)
                        .frame(width: cardWidth)
                }
            }
            .frame(width: contentWidth, height: geometry.size.height, alignment: .leading)
            .offset(x: offset)
            .animation(.easeInOut, value: currentIndex)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        let newIndex = value.predictedEndTranslation.width < -threshold ? min(currentIndex + 1, movies.count - 1) : value.predictedEndTranslation.width > threshold ? max(currentIndex - 1, 0) : currentIndex
                        currentIndex = newIndex
                    }
            )
        }
        .padding(.horizontal, 20)
    }
    
    private func moviePosterView(movie: Movie) -> some View {
        VStack(spacing: 10) {
            Image("testPoster")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 200, height: 300)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 30)
            
            movieTextPoster(movie: movie)
            
        }
    }
    
    private func movieTextPoster(movie: Movie) -> some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text(movie.title)
                .font(.title)
                .foregroundStyle(.white)
            
            
            
            HStack {
                ForEach(movie.genreIDS, id: \.self) { genreID in
                    Text("\(movieVM.returnGenreName(genreID: genreID))")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
            
            
            
            HStack(alignment: .center) {
                Text(movie.voteAverage.asNumberString())
                    .font(.title)
                    .foregroundStyle(.white)
                
                Image(systemName: "hands.clap.fill")
                    .foregroundStyle(.white)
            }
        }
    }
    
}

#Preview {
    HomeView(movies: DeveloperPreview.instance.moviesList)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
}
