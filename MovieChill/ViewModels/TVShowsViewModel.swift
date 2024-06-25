//
//  TVShowsViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation
import SwiftUI

@MainActor
class TVShowsViewModel: ObservableObject {
    
    @Published var tvShowsList: [TVModel] = []
    @Published var tvShowSheet: TVModel?
    @Published var isLoading: Bool = false
    
    private var nextPage: String? = ApiPaths().getValue(api: .tvShows)
    private var constants = MovieChillConstants()
    private var tvShowsRepository = TVRepository()
    
    @Published var pageNumber: Int = 1
    
    
    init() {}
    
    func fetchTVShows(shouldSetLoader: Bool = true) async {
        
        guard !isLoading, let urlString = nextPage else { return }
        
        if shouldSetLoader {
            setIsLoading(to: true)
        }
        
        let pNumber = String(pageNumber)
        
        do {
            let data  = try await tvShowsRepository.getTVShows(urlString: urlString, type: TVModelResults.self, page: pNumber)
            await updateTVShowList(with: data, should: shouldSetLoader)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateTVShowList(with data: TVModelResults, should setLoader: Bool = true) async {
        let updatedTVShows = data.results.map { tvShow in
            tvShow.updatePostersPath(newPathPoster: ApiPaths().getValue(api: .posters, concatValue: tvShow.posterPath),
                                    newPathBackdrop:  ApiPaths().getValue(api: .posters, concatValue: tvShow.backdropPath)
            )
        }
        
        self.tvShowsList.append(contentsOf: updatedTVShows)
        
        for tvShow in updatedTVShows {
            if let poster = tvShow.fullPosterPath {
                await fetchTVShowPoster(from: poster, for: tvShow, should: setLoader)
            }
        }
        setIsLoading(to: false)
    }
    
    func fetchTVShowPoster(from fullPosterPath: String, for tvShow: TVModel, should setLoader: Bool = true) async {
        if setLoader {
            setIsLoading(to: true)
        }
        
        do {
            let data = try await tvShowsRepository.getTVShowPoster(urlString: fullPosterPath)
            let image = Image(uiImage: data)
            await updateTVShowPoster(for: tvShow, with: image)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateTVShowPoster(for tvShow: TVModel, with image: Image) async {
        if let index = tvShowsList.firstIndex(where: { $0.id == tvShow.id }) {
            var updatedTVShow = tvShow
            updatedTVShow.imageData = image
            tvShowsList[index] = updatedTVShow
        }
    }
    
    func fetchTVShowBackdropPoster(from fullBackdropPosterPath: String, for tvShow: TVModel) async {
        do {
            let data = try await tvShowsRepository.getTVShowPoster(urlString: fullBackdropPosterPath)
            let image = Image(uiImage: data)
            await updateTVShowBackdropPoster(for: tvShow, with: image)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func updateTVShowBackdropPoster(for tvShow: TVModel, with image: Image) async {
        if let index = tvShowsList.firstIndex(where: { $0.id == tvShow.id }) {
            var updatedTVShows = tvShow
            updatedTVShows.backdropData = image
            if
                let imgPoster = updatedTVShows.imageData,
                let imgBack = updatedTVShows.backdropData {
                updatedTVShows.detailsImageList = [imgPoster, imgBack]
            }
            tvShowsList[index] = updatedTVShows
        }
    }
    
    // call from view
    func fetchBackdropPosters() async {
        for tvShow in tvShowsList {
            if let backdrop = tvShow.fullBackdropPath {
                await fetchTVShowBackdropPoster(from: backdrop, for: tvShow)
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
    
    func setPageNumber(value: Int) {
        pageNumber = value
    }
    
}
