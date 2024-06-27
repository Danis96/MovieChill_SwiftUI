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
    @Published var credits: [Cast] = []
    @Published var showMoreCast: Bool = false

    
    private var constants = MovieChillConstants()
    private var movieRepository = MovieRepository()
    private var creditsRepository = CreditsRepository()
    
    @Published var pageNumber: Int = 1
    
    
    init() {}
    
    
    // MARK: movies
    func fetchMovies(shouldSetLoader: Bool = true) async {
        
        guard !isLoading else { return }
        
        if shouldSetLoader {
            setIsLoading(to: true)
        }
        
        let pNumber = String(pageNumber)
        
        do {
            let data  = try await movieRepository.getMovies(type: MovieModel.self, page: pNumber)
            await updateMovieList(with: data, should: shouldSetLoader)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateMovieList(with data: MovieModel, should setLoader: Bool = true) async {
        let updatedMovies = data.results.map { movie in
            movie.updatePostersPath(newPathPoster: ApiPaths().getValue(api: .posters, concatValue: movie.posterPath),
                                    newPathBackdrop:  ApiPaths().getValue(api: .posters, concatValue: movie.backdropPath)
            )
        }
        
        self.movieList.append(contentsOf: updatedMovies)
        
        for movie in updatedMovies {
            if let poster = movie.fullPosterPath {
                await fetchMoviePoster(from: poster, for: movie, should: setLoader)
            }
        }
        setIsLoading(to: false)
    }
    
    
    // MARK: movie poster
    func fetchMoviePoster(from fullPosterPath: String, for movie: Movie, should setLoader: Bool = true) async {
        if setLoader {
            setIsLoading(to: true)
        }
        
        do {
            let data = try await movieRepository.getMoviePoster(urlString: fullPosterPath)
            let image = Image(uiImage: data)
            await updateMoviePoster(for: movie, with: image)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateMoviePoster(for movie: Movie, with image: Image) async {
        if let index = movieList.firstIndex(where: { $0.id == movie.id }) {
            var updatedMovie = movie
            updatedMovie.imageData = image
            movieList[index] = updatedMovie
        }
    }
    
    // MARK: movie backdrop poster
    func fetchMovieBackdropPoster(from fullBackdropPosterPath: String, for movie: Movie) async {
        do {
            let data = try await movieRepository.getMoviePoster(urlString: fullBackdropPosterPath)
            let image = Image(uiImage: data)
            await updateMovieBackdropPoster(for: movie, with: image)
        } catch let error {
            await handleFetchError(error)
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
    
    // call from view
    func fetchBackdropPosters() async {
        for movie in movieList {
            if let backdrop = movie.fullBackdropPath {
                await fetchMovieBackdropPoster(from: backdrop, for: movie)
            }
        }
    }
    
    private func handleFetchError(_ error: Error) async {
        setIsLoading(to: false)
        print("Error fetching movies: \(error.localizedDescription)")
        if let networkError = error as? NetworkError {
            print("Detailed Error: \(networkError.localizedDescription)")
        }
    }
    
    
    // MARK: credits / cast
    func fetchCredits(for id: String) async {
        self.credits.removeAll()
        
        do {
            let data = try await creditsRepository.getCredits(for: id, type: CreditsModel.self)
            await updateCredits(with: data)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateCredits(with data: CreditsModel) async {
        let updatedCredits = data.cast.map { cast in
            cast.updateProfilePath(newPathProfile: ApiPaths().getValue(api: .posters, concatValue: cast.profilePath ?? ""))
        }
        
        self.credits.append(contentsOf: updatedCredits)
        
        for credit in updatedCredits {
            if let poster = credit.profileFullPath {
                await fetchCastPoster(from: poster, for: credit)
            }
        }
    }
    
    func fetchCastPoster(from fullPosterPath: String, for cast: Cast) async {
        do {
            let data = try await movieRepository.getMoviePoster(urlString: fullPosterPath)
            let image = Image(uiImage: data)
            await updateCastPoster(for: cast, with: image)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateCastPoster(for cast: Cast, with image: Image) async {
        if let index = credits.firstIndex(where: { $0.id == cast.id }) {
            var updatedCast = cast
            updatedCast.imageData = image
            credits[index] = updatedCast
        }
    }
    
    /// if showMoreCast is false return only 4 cast members
    func returnCreditsBasedOnShowMore() -> [Cast] {
        if showMoreCast {
            return credits
        } else {
            var fourCastArray: [Cast] = []
            if !credits.isEmpty && credits.count > 4 {
                fourCastArray.append(contentsOf: credits.prefix(4))
            }
            return fourCastArray.isEmpty ? credits : fourCastArray
        }
    }
    
    private func setIsLoading(to newValue: Bool) {
        isLoading = newValue
    }
    
    func setPageNumber(value: Int) {
        pageNumber = value
    }
    
    
    
}
