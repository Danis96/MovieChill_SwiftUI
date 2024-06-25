//
//  HomeView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

struct MovieView: View {
    
    @EnvironmentObject var movieVM: MovieViewModel
    
    @State private var currentIndex = 0
    
    var body: some View {
        VStack() {
            movieScrollView
                .padding(.vertical, 40)
                .sheet(item: $movieVM.movieSheet) { movie in
                    MovieDetailsView(movie: movie)
                        .environmentObject(movieVM)
                }
            
            dotIndicators
                .padding(20)
            
            HStack {
                if currentIndex != 0 {
                    previousButton()
                }
                Spacer()
                if currentIndex < movieVM.movieList.count - 1 {
                    nextButton()
                }
            }.padding(.horizontal, 25)
            
        }.animation(.easeInOut(duration: 0.5), value: currentIndex)
    }
}


extension MovieView {
    
    private var dotIndicators: some View {
        HStack {
            ForEach(0..<movieVM.movieList.count, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? Color.white : Color.gray)
                    .frame(width: 10, height: 10)
            }
        }
    }
    
    private var movieScrollView: some View {
        GeometryReader { geometry in
            if movieVM.isLoading {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                HStack(spacing: 20) {
                    ForEach(Array(movieVM.movieList.enumerated()), id: \.offset) { index, movie in
                        moviePosterView(movie: movie, index: index)
                            .frame(width: geometry.size.width)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                            .opacity(currentIndex == index ? 1.0 : 0.0)
                            .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            .onTapGesture {
                                withAnimation {
                                    currentIndex = index
                                    movieVM.movieSheet = movie
                                }
                    }
                }
            }
                .offset(x: CGFloat(currentIndex) * -(geometry.size.width + 20))
        }
    }
}

private func moviePosterView(movie: Movie, index: Int) -> some View {
    VStack(spacing: 40) {
        if let posterImage = movie.imageData {
            posterImage
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 200, height: 300)
                .cornerRadius(10)
                .shadow(radius: 15)
        }
        
        movieTextPoster(movie: movie, index: index)
    }
}

private func movieTextPoster(movie: Movie, index: Int) -> some View {
    VStack(alignment: .center, spacing: 10) {
        if currentIndex == index {
            Text(movie.title)
                .frame(maxWidth: UIScreen.main.bounds.width / 1.2)
                .font(.title)
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            
            
            
            HStack {
                ForEach(movie.genreIDS.prefix(3), id: \.self) { genreID in
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

private func calculateOffset(cardWidth: CGFloat, spacing: CGFloat, geometry: GeometryProxy) -> CGFloat {
    let centeredOffset = (geometry.size.width - cardWidth) / 2
    let indexOffset = CGFloat(currentIndex) * -(cardWidth + spacing)
    
    return indexOffset + centeredOffset
}

private func nextButton() -> some View {
    Button(action: {
        withAnimation(.spring) {
            currentIndex = min(currentIndex + 1, movieVM.movieList.count - 1)
        }
    }, label: {
        Text("Next")
            .font(.headline)
            .frame(width: 100)
    }).buttonStyle(.bordered)
        .foregroundStyle(.white.opacity(0.7))
}

private func previousButton() -> some View {
    Button(action: {
        withAnimation(.spring) {
            currentIndex = max(currentIndex - 1, 0)
        }
    }, label: {
        Text("Previous")
            .font(.headline)
            .frame(width: 100)
    }).buttonStyle(.bordered)
        .foregroundStyle(.white.opacity(0.7))
}

}

#Preview {
    TopTabsView()
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.tabsViewModel)
}
