//
//  MovieChillApp.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

@main
struct MovieChillApp: App {
    
    @StateObject var tabViewModel = TabViewModel()
    @StateObject var movieViewModel = MovieViewModel()
    @StateObject var tvShowViewModel = TVShowsViewModel()
    @StateObject var reviewsViewModel = ReviewsViewModel()
    @StateObject var ratingViewModel = RatingViewModel()
    @StateObject var certificationViewModel = CertificationViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TopTabsView()
            }
        }
        .environmentObject(tabViewModel)
        .environmentObject(movieViewModel)
        .environmentObject(tvShowViewModel)
        .environmentObject(reviewsViewModel)
        .environmentObject(ratingViewModel)
        .environmentObject(certificationViewModel)
    }
}
