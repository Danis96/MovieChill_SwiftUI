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

    private(set) lazy var reviewsViewModel: ReviewsViewModel = {
        ReviewsViewModel()
    }()

    private(set) lazy var ratingViewModel: RatingViewModel = {
        RatingViewModel()
    }()

    private(set) lazy var certificationViewModel: CertificationViewModel = {
        CertificationViewModel()
    }()
    
    let movie = Movie(adult: false, backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg", fullPosterPath: "", fullBackdropPath: "", genreIDS: [16,10751,18,12,35], movieID: 1022789, originalLanguage: .en, originalTitle: "Inside Out 2", overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.", popularity: 8282.191, posterPath: "/oxxqiyWrnM0XPnBtVe9TgYWnPxT.jpg", releaseDate: "2024-06-11", title: "Inside Out 2", video: false, voteAverage: 7.8, voteCount: 660, detailsImageList: [Image("testApesPoster"), Image("testPoster")] )

    let tvShow = TVModel(adult: false, backdropPath: "", fullPosterPath: "", fullBackdropPath: "", genreIDS: [0], id: "", televisionID: 1, originCountry: [""], originalLanguage: .af, originalName: "", overview: "", popularity: 1.0, posterPath: "", firstAirDate: "", name: "Title", voteAverage: 1.0, voteCount: 1, imageData: nil, backdropData: nil, detailsImageList: [Image("testApesPoster"), Image("testPoster")])
    
    let moviesList = [
        Movie(adult: false, backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg", fullPosterPath: "", fullBackdropPath: "", genreIDS: [16,10751,18,12,35], movieID: 1022789, originalLanguage: .en, originalTitle: "Inside Out 2", overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.", popularity: 8282.191, posterPath: "/oxxqiyWrnM0XPnBtVe9TgYWnPxT.jpg", releaseDate: "2024-06-11", title: "Inside Out 2", video: false, voteAverage: 7.8, voteCount: 660),
        
        Movie(adult: false, backdropPath: "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg", fullPosterPath: "", fullBackdropPath: "", genreIDS: [16,10751,18,12,35], movieID: 653346, originalLanguage: .en, originalTitle: "Kingdom of the Planet of the Apes", overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.", popularity: 3444.493, posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg", releaseDate: "2024-05-08", title: "Kingdom of the Planet of the Apes", video: false, voteAverage: 6.881, voteCount: 1193)
    ]
    
    let cast = Cast(adult: false, gender: 2, id: 1748, knownForDepartment: "Acting", name: "William Shatner", originalName: "William Shatner", popularity: 18.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 5, character: "Admiral James T. Kirk", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: nil)
    
    let castList = [
        Cast(adult: false, gender: 2, id: 17121248, knownForDepartment: "Acting", name: "William Shatner", originalName: "William Shatner", popularity: 18.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 5, character: "Admiral James T. Kirk", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: Image("testPoster")),
        
        Cast(adult: false, gender: 1, id: 1738, knownForDepartment: "Acting", name: "Angelina Jolie", originalName: "Angelina Jolie", popularity: 24.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 2, character: "Godess", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: Image("testApesPoster")),
        
        Cast(adult: false, gender: 2, id: 17438, knownForDepartment: "Acting", name: "William Shatner", originalName: "William Shatner", popularity: 18.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 5, character: "Admiral James T. Kirk", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: Image("testPoster")),
        
        Cast(adult: false, gender: 1, id: 17238, knownForDepartment: "Acting", name: "Angelina Jolie", originalName: "Angelina Jolie", popularity: 24.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 2, character: "Godess", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: Image("testApesPoster")),
        
        Cast(adult: false, gender: 2, id: 11748, knownForDepartment: "Acting", name: "William Shatner", originalName: "William Shatner", popularity: 18.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 5, character: "Admiral James T. Kirk", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: Image("testPoster")),
        
        Cast(adult: false, gender: 1, id: 12738, knownForDepartment: "Acting", name: "Angelina Jolie", originalName: "Angelina Jolie", popularity: 24.463, profilePath: "/7lsjbNFMGj3kYYWoMk1LNnl4p5P.jpg", castID: 2, character: "Godess", creditID: "52fe421fc3a36847f8005c03", order: 0, department: nil, job: nil, profileFullPath: nil, imageData: Image("testApesPoster")),
    ]
    
    let review = ReviewModel(author: "CinemaSerf", authorDetails: AuthorDetails(name: "CinemaSerf", username: "Geronimo1967", avatarPath: "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg", rating: 7), content: "This is much more like it. William Shatner leads our intrepid band of intergalactic explorers on an all action adventure to save the universe for the evil super-intellect of \"Khan\" (a wonderfully hammy Ricardo Montalban) as he escapes from imprisonment on a desolate desert planet and seeks violent revenge on \"Admiral Kirk\". This has none of the philosophical pretensions of the first film, it is just a sci-fi shoot 'em up with great visual effects and the occasional chunk of Herman Melville thrown in for theatrical good measure as they strive to stop \"genesis\" from rearranging everyone's chronometers. Despite the intervention of some interlopers (all part of \"Kirk\", his past and his love life), the original crew all bond together nicely as we trek towards an exciting conclusion that leaves us well set for \"Star Trek III\".", createdAt: "2022-07-01T20:26:13.566Z", id: "62bf5865af6e94046c7070de", updatedAt: "2023-06-08T08:01:54.005Z", url: "https://www.themoviedb.org/review/62bf5865af6e94046c7070de")
    
    let reviewsList: [ReviewModel] = [
        ReviewModel(author: "CinemaSerf", authorDetails: AuthorDetails(name: "CinemaSerf", username: "Geronimo1967", avatarPath: "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg", rating: 7), content: "This is much more like it. William Shatner leads our intrepid band of intergalactic explorers on an all action adventure to save the universe for the evil super-intellect of \"Khan\" (a wonderfully hammy Ricardo Montalban) as he escapes from imprisonment on a desolate desert planet and seeks violent revenge on \"Admiral Kirk\". This has none of the philosophical pretensions of the first film, it is just a sci-fi shoot 'em up with great visual effects and the occasional chunk of Herman Melville thrown in for theatrical good measure as they strive to stop \"genesis\" from rearranging everyone's chronometers. Despite the intervention of some interlopers (all part of \"Kirk\", his past and his love life), the original crew all bond together nicely as we trek towards an exciting conclusion that leaves us well set for \"Star Trek III\".", createdAt: "2022-07-01T20:26:13.566Z", id: "62bf5865af6e94046c7070de", updatedAt: "2023-06-08T08:01:54.005Z", url: "https://www.themoviedb.org/review/62bf5865af6e94046c7070de"),
        ReviewModel(author: "CinemaSerf", authorDetails: AuthorDetails(name: "CinemaSerf", username: "Geronimo1967", avatarPath: "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg", rating: 7), content: "This is much more like it. William Shatner leads our intrepid band of intergalactic explorers on an all action adventure to save the universe for the evil super-intellect of \"Khan\" (a wonderfully hammy Ricardo Montalban) as he escapes from imprisonment on a desolate desert planet and seeks violent revenge on \"Admiral Kirk\". This has none of the philosophical pretensions of the first film, it is just a sci-fi shoot 'em up with great visual effects and the occasional chunk of Herman Melville thrown in for theatrical good measure as they strive to stop \"genesis\" from rearranging everyone's chronometers. Despite the intervention of some interlopers (all part of \"Kirk\", his past and his love life), the original crew all bond together nicely as we trek towards an exciting conclusion that leaves us well set for \"Star Trek III\".", createdAt: "2022-07-01T20:26:13.566Z", id: "62bf5865af6e94046c7070de", updatedAt: "2023-06-08T08:01:54.005Z", url: "https://www.themoviedb.org/review/62bf5865af6e94046c7070de")
    ]
    
    let alertTest: Bool = false
    
    let certificationList: [CertificationGroup] = [
      CertificationGroup(certifications: [
         Certification(certification: "Danis", meaning: "Test", order: 2)
      ], country: "BiH"),
      CertificationGroup(certifications: [
         Certification(certification: "Title", meaning: "Test", order: 4)
      ], country: "Croatia"),
      CertificationGroup(certifications: [
         Certification(certification: "Title", meaning: "Test", order: 14)
      ], country: "USA")
    ]
    
    private init() { }
    
}
