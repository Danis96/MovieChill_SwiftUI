//
//  MovieChillApp.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

@main
struct MovieChillApp: App {
    
    @StateObject  var tabViewModel = TabViewModel()
    @StateObject  var movieViewModel = MovieViewModel()
    @StateObject  var tvShowViewModel = TVShowsViewModel()
    
    var body: some Scene {
        WindowGroup {
            TopTabsView()
        }
        .environmentObject(tabViewModel)
        .environmentObject(movieViewModel)
        .environmentObject(tvShowViewModel)
    }
}
