//
//  MovieChillApp.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

@main
struct MovieChillApp: App {
    
    @StateObject private var tabViewModel = TabViewModel()
    @StateObject private var movieViewModel = MovieViewModel()
    
    var body: some Scene {
        WindowGroup {
            TopTabsView()
                .environmentObject(TabViewModel())
                .environmentObject(MovieViewModel())
        }
    }
}
