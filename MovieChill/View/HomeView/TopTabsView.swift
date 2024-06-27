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
    
    private var locale = LocaleStrings()
    
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
            gradient: Gradient(colors: [Color("BackgroundBlue1"),Color("BackgroundBlue2")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).ignoresSafeArea()
    }
    
    private var toolbarMenuItem: some View {
        Button(action: {}, label: {
            Image(systemName: "pedal.clutch.fill")
                .foregroundStyle(Color("TextColor"))
        })
    }
    
    private var toolbarSearchItem: some View {
        Button(action: {}, label: {
            Image(systemName: "waveform.badge.magnifyingglass")
                .foregroundStyle(Color("TextColor"))
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
                    .foregroundColor(tabVM.selectedTab == tab ? Color("TextColor") : Color("TextColor").opacity(0.6))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 50)
    }
    
    private var tabsItems: some View {
        VStack {
            switch tabVM.selectedTab.title {
            case locale.ttvDiscoverMovies:
                MovieView()
                    .environmentObject(movieVM)
            case locale.ttvDiscoverTV:
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
        .environmentObject(DeveloperPreview.instance.tvShowViewModel)
}
