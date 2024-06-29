//
//  HomeView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

struct MovieView: View {
    
    @EnvironmentObject var movieVM: MovieViewModel
    @EnvironmentObject var reviewsVM: ReviewsViewModel
    
    @State private var currentIndex = 0
    private var locale = LocaleStrings()
    
    var body: some View {
        VStack {
            movieScrollView
                .padding(.vertical, 40)
                .sheet(item: $movieVM.movieSheet) { movie in
                    MovieDetailsView(movie: movie)
                }
            
            HStack {
                if currentIndex != 0 {
                    previousButton
                }
                Spacer()
                if currentIndex < movieVM.movieList.count - 1 {
                    nextButton
                }
            }.padding(.horizontal, 25)
                .foregroundStyle(Color("TextColor").opacity(0.7))
            
        }.animation(.easeInOut(duration: 0.5), value: currentIndex)
    }
}


extension MovieView {
    
    private var movieScrollView: some View {
        GeometryReader { geometry in
            if movieVM.isLoading {
                ProgressView()
                    .tint(Color("TextColor"))
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                movieScrollViewContent(geometry: geometry)
            }
        }
    }
    
    private func movieScrollViewContent(geometry: GeometryProxy) -> some View {
        HStack(spacing: 20) {
            ForEach(Array(movieVM.movieList.enumerated()), id: \.offset) { index, movie in
                ItemCardView(
                    image: movie.imageData ?? Image(systemName: "arrow.down"),
                    currentIndex: currentIndex,
                    index: index,
                    geometry: geometry,
                    onTapPressed: {
                        await onCardPressed(movie: movie, index: index)
                    },
                    title: movie.title,
                    voteAverage: movie.voteAverage.asNumberString(),
                    genreIDS: movie.genreIDS)
                
            }
        }
        .offset(x: CGFloat(currentIndex) * -(geometry.size.width + 20))
    }
    
    private func onCardPressed(movie: Movie, index: Int) async {
        Task {
            await movieVM.fetchCredits(for: String(movie.movieID))
            await reviewsVM.fetchReviews(for: movie.movieID)
        }
        withAnimation {
            currentIndex = index
            movieVM.movieSheet = movie
            movieVM.showMoreCast = false
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            Task {await nextButtonAction()}
        }, label: {
            Text(locale.movieViewBtnNext)
                .font(.headline)
                .frame(width: 100)
        }).buttonStyle(.bordered)
        
    }
    
    private func nextButtonAction() async {
        withAnimation(.spring) {
            currentIndex = min(currentIndex + 1, movieVM.movieList.count - 1)
            if currentIndex == movieVM.movieList.count - 2 {
                movieVM.setPageNumber(value: movieVM.pageNumber + 1)
                Task {
                    await movieVM.fetchMovies(shouldSetLoader: false)
                    await movieVM.fetchBackdropPosters()
                }
            }
        }
    }
    
    private var previousButton: some View {
        Button(action: {
            withAnimation(.spring) {currentIndex = max(currentIndex - 1, 0)}
        }, label: {
            Text(locale.movieViewBtnPrevious)
                .font(.headline)
                .frame(width: 100)
        }).buttonStyle(.bordered)
    }
}

#Preview {
    TopTabsView()
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.tabsViewModel)
        .environmentObject(DeveloperPreview.instance.tvShowViewModel)
        .environmentObject(DeveloperPreview.instance.reviewsViewModel)
}
