//
//  TopTabsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import SwiftUI

struct TopTabsView: View {
    @EnvironmentObject var tabVM: TabViewModel
    @EnvironmentObject var movieVM: MovieViewModel
    @EnvironmentObject var tvShowVM: TVShowsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                VStack(alignment: .center, spacing: 0) {
                    tabsList
                    tabsItems
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    toolbarMenuItem
                }
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarSearchItem
                }
            })
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    await movieVM.fetchMovies()
                    await movieVM.fetchBackdropPosters()
                    await tvShowVM.fetchTVShows()
                    await tvShowVM.fetchBackdropPosters()
                }
            }
            
        }
    }
}

extension TopTabsView {
    
    private var backgroundView: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.init(red: 101 / 255, green: 157 / 255, blue: 213 / 255), Color.init(red: 66 / 255, green: 80 / 255, blue: 158 / 255)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).ignoresSafeArea()
    }
    
    private var toolbarMenuItem: some View {
        Button(action: {}, label: {
            Image(systemName: "pedal.clutch.fill")
                .foregroundStyle(.white)
        })
    }
    
    private var toolbarSearchItem: some View {
        Button(action: {}, label: {
            Image(systemName: "waveform.badge.magnifyingglass")
                .foregroundStyle(.white)
        })
    }
    
    private var tabsList: some View {
        HStack {
            ForEach(tabVM.tabs) { tab in
                Button(action: {
                    withAnimation(.easeInOut) {
                        tabVM.selectedTab = tab
                    }
                }) {
                    VStack {
                        Text(tab.title)
                            .font(tabVM.selectedTab == tab ? .headline : .subheadline)
                        
                        if tabVM.selectedTab == tab {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 50, height: 5)
                        }
                    }
                    .padding()
                    .foregroundColor(tabVM.selectedTab == tab ? .white : .white.opacity(0.6))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 50)
    }
    
    private var tabsItems: some View {
        VStack {
            switch tabVM.selectedTab.title {
            case "Discover Movies":
                MovieView()
                    .environmentObject(movieVM)
            case "TV":
                TVShowView()
                    .environmentObject(tvShowVM)
            default:
                Text("Unknown tab")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    TopTabsView()
        .environmentObject(DeveloperPreview.instance.tabsViewModel)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
}
