//
//  PreviewProvider.swift
//  SWAPI
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation
import SwiftUI


extension Preview {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

@MainActor
class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    // lazy initializations is ensuring that it is tunning on the main thread
    private(set) lazy var tabsViewModel: TabViewModel = {
        TabViewModel()
    }()
    
    private(set) lazy var movieViewModel: MovieViewModel = {
        MovieViewModel()
    }()

    private(set) lazy var tvShowViewModel: TVShowsViewModel = {
        TVShowsViewModel()
    }()
    
    let movie = Movie(adult: false, backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg", fullPosterPath: "", fullBackdropPath: "", genreIDS: [16,10751,18,12,35], movieID: 1022789, originalLanguage: .en, originalTitle: "Inside Out 2", overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.", popularity: 8282.191, posterPath: "/oxxqiyWrnM0XPnBtVe9TgYWnPxT.jpg", releaseDate: "2024-06-11", title: "Inside Out 2", video: false, voteAverage: 7.8, voteCount: 660, detailsImageList: [Image("testApesPoster"), Image("testPoster")] )
    
    let moviesList = [
        Movie(adult: false, backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg", fullPosterPath: "", fullBackdropPath: "", genreIDS: [16,10751,18,12,35], movieID: 1022789, originalLanguage: .en, originalTitle: "Inside Out 2", overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.", popularity: 8282.191, posterPath: "/oxxqiyWrnM0XPnBtVe9TgYWnPxT.jpg", releaseDate: "2024-06-11", title: "Inside Out 2", video: false, voteAverage: 7.8, voteCount: 660),
        
        Movie(adult: false, backdropPath: "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg", fullPosterPath: "", fullBackdropPath: "", genreIDS: [16,10751,18,12,35], movieID: 653346, originalLanguage: .en, originalTitle: "Kingdom of the Planet of the Apes", overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.", popularity: 3444.493, posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg", releaseDate: "2024-05-08", title: "Kingdom of the Planet of the Apes", video: false, voteAverage: 6.881, voteCount: 1193)
    ]
    
    
    private init() { }
    
}
