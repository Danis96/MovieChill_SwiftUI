//
//  TVShowView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI


struct TVShowView: View {
    
    @EnvironmentObject var tvShowVM: TVShowsViewModel
    @EnvironmentObject var reviewsVM: ReviewsViewModel
    
    @State private var currentIndex = 0
    private var locale = LocaleStrings()
    
    var body: some View {
        VStack {
            tvShowScrollView
                .padding(.vertical, 40)
                .sheet(item: $tvShowVM.tvShowSheet) { tvShow in
                    TVShowDetailsView(tvShow: tvShow)
                        .environmentObject(tvShowVM)
                }
            
            HStack {
                if currentIndex != 0 {
                    previousButton
                }
                Spacer()
                if currentIndex < tvShowVM.tvShowsList.count - 1 {
                    nextButton
                }
            }.padding(.horizontal, 25)
                .foregroundStyle(Color("TextColor"))
            
        }.animation(.easeInOut(duration: 0.5), value: currentIndex)
    }
}


extension TVShowView {
    
    private var tvShowScrollView: some View {
        GeometryReader { geometry in
            if tvShowVM.isLoading {
                ProgressView()
                    .tint(Color("TextColor"))
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                tvScrollViewContent(geometry: geometry)
            }
        }
    }
    
    private func tvScrollViewContent(geometry: GeometryProxy) -> some View {
        HStack(spacing: 20) {
            ForEach(Array(tvShowVM.tvShowsList.enumerated()), id: \.offset) { index, tvShow in
                ItemCardView(
                    image: tvShow.imageData ?? Image(systemName: "arrow.down"),
                    currentIndex: currentIndex,
                    index: index,
                    geometry: geometry,
                    onTapPressed: {
                     await onCardPressed(tvShow: tvShow, index: index)
                    },
                    title: tvShow.name,
                    voteAverage: tvShow.voteAverage.asNumberString(),
                    genreIDS: tvShow.genreIDS)
            }
        }
        .offset(x: CGFloat(currentIndex) * -(geometry.size.width + 20))
    }
    
    private func onCardPressed(tvShow: TVModel, index: Int) async {
        Task {
            await tvShowVM.fetchCredits(for: String(tvShow.televisionID))
            await reviewsVM.fetchReviews(for: tvShow.televisionID, isTv: true)
        }
        withAnimation {
            currentIndex = index
            tvShowVM.tvShowSheet = tvShow
            tvShowVM.showMoreCast = false
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            Task {
                await nextButtonAction()
            }
        }, label: {
            Text(locale.tvShowViewBtnNext)
                .font(.headline)
                .frame(width: 100)
        }).buttonStyle(.bordered)
    }
    
    private func nextButtonAction() async {
        withAnimation(.spring) {
            currentIndex = min(currentIndex + 1, tvShowVM.tvShowsList.count - 1)
            if currentIndex == tvShowVM.tvShowsList.count - 2 {
                tvShowVM.setPageNumber(value: tvShowVM.pageNumber + 1)
                Task {
                    await tvShowVM.fetchTVShows(shouldSetLoader: false)
                    await tvShowVM.fetchBackdropPosters()
                }
            }
        }
    }
    
    private var previousButton: some View {
        Button(action: {
            withAnimation(.spring) {
                currentIndex = max(currentIndex - 1, 0)
            }
        }, label: {
            Text(locale.tvShowViewBtnPrevious)
                .font(.headline)
                .frame(width: 100)
        }).buttonStyle(.bordered)
    }
    
}

#Preview {
    TopTabsView()
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.tabsViewModel)
        .environmentObject(DeveloperPreview.instance.tvShowViewModel)
        .environmentObject(DeveloperPreview.instance.reviewsViewModel)
    
}
