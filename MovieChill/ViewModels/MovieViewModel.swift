//
//  MovieViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 24. 6. 2024..
//

import Foundation
import SwiftUI

@MainActor
class MovieViewModel: ObservableObject {
    
    @Published var movieList: [Movie] = []
    @Published var movieSheet: Movie?
    @Published var isLoading: Bool = false
    @Published var isLoadingDetails: Bool = false
    
    private var nextPage: String? = ApiPaths().getValue(api: .movies)
    private var constants = MovieChillConstants()
    private var movieRepository = MovieRepository()
    
    init() {}
    
    func fetchMovies() async {
        
        guard !isLoading, let urlString = nextPage else { return }
        
        setIsLoading(to: true)
        
        do {
            let data  = try await movieRepository.getMovies(urlString: urlString, type: MovieModel.self)
            await updateMovieList(with: data)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    func fetchMoviePoster(from fullPosterPath: String, for movie: Movie) async {
        setIsLoading(to: true)
        do {
            let data = try await movieRepository.getMoviePoster(urlString: fullPosterPath)
            let image = Image(uiImage: data)
            await updateMoviePoster(for: movie, with: image)
        } catch let error {
            await handleFetchError(error)
        }
    }

    func fetchMovieBackdropPoster(from fullBackdropPosterPath: String, for movie: Movie) async {
        setIsLoadingDetails(to: true)
        do {
            let data = try await movieRepository.getMoviePoster(urlString: fullBackdropPosterPath)
            let image = Image(uiImage: data)
            await updateMovieBackdropPoster(for: movie, with: image)
            setIsLoadingDetails(to: false)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    
    
    private func updateMovieList(with data: MovieModel) async {
        let updatedMovies = data.results.map { movie in
            movie.updatePostersPath(newPathPoster: ApiPaths().getValue(api: .posters, concatValue: movie.posterPath),
                                    newPathBackdrop:  ApiPaths().getValue(api: .posters, concatValue: movie.backdropPath)
            )
        }
        
        self.movieList.append(contentsOf: updatedMovies)
        
        for movie in updatedMovies {
            if let poster = movie.fullPosterPath {
                await fetchMoviePoster(from: poster, for: movie)
            }
        }
        setIsLoading(to: false)
    }
    
    
    private func updateMoviePoster(for movie: Movie, with image: Image) async {
        if let index = movieList.firstIndex(where: { $0.id == movie.id }) {
            var updatedMovie = movie
            updatedMovie.imageData = image
            movieList[index] = updatedMovie
        }
    }

    private func updateMovieBackdropPoster(for movie: Movie, with image: Image) async {
        if let index = movieList.firstIndex(where: { $0.id == movie.id }) {
            var updatedMovie = movie
            updatedMovie.backdropData = image
            if 
                let imgPoster = updatedMovie.imageData,
                let imgBack = updatedMovie.backdropData {
                updatedMovie.detailsImageList = [imgPoster, imgBack]
            }
            movieList[index] = updatedMovie
        }
    }
    
    private func handleFetchError(_ error: Error) async {
        setIsLoading(to: false)
        setIsLoadingDetails(to: false)
        print("Error fetching movies: \(error.localizedDescription)")
        if let networkError = error as? NetworkError {
            print("Detailed Error: \(networkError.localizedDescription)")
        }
    }
    
    func returnGenreName(genreID: Int) -> String {
        for genre in constants.genres {
            if(genreID == genre.id) {
                return "\(genre.name) /"
            }
        }
        return ""
    }
    
    private func setIsLoading(to newValue: Bool) {
        isLoading = newValue
    }

    private func setIsLoadingDetails(to newValue: Bool) {
        isLoadingDetails = newValue
    }
    
    
    
}
