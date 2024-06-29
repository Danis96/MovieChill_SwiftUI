//
//  TVShowDetailsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI


struct TVShowDetailsView: View {
    
    @EnvironmentObject private var tvShowVM: TVShowsViewModel
    @EnvironmentObject private var reviewsVM: ReviewsViewModel
    let tvShow: TVModel
    
    private let locale = LocaleStrings()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    imageSection
                    
                    infoText
                    
                    Divider()
                    
                    overviewSection
                    
                    Divider()
                    
                    CreditsSectionView(credits: tvShowVM.returnCreditsBasedOnShowMore(), isTV: true)
                    
                }.overlay(alignment: .topLeading) {
                    xMarkButton
                }
            }.ignoresSafeArea()
        }
    }
}

extension TVShowDetailsView {
    private var imageSection: some View {
        TabView {
            if let images = tvShow.detailsImageList {
                ForEach(images.indices, id: \.self) { index in
                    images[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                        .clipped()
                        .shadow(radius: 10)
                }
            }
        }
        .frame(height: 550)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(locale.tvDetailsOverview)
                .font(.headline)
            Text(tvShow.overview)
        }
        .padding()
    }
    
    private var xMarkButton: some View {
        Button(action: {
            tvShowVM.tvShowSheet = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.title2)
                .foregroundStyle(.black)
                .frame(width: 45, height: 45)
                .background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(26)
        })
    }
    
    private var infoText: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("\(tvShow.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack {
                    Text(tvShow.voteAverage.asNumberString())
                        .font(.headline)
                    Image(systemName: "hands.clap")
                }
                
                Text("\(locale.tvDetailsAirDate) \(tvShow.firstAirDate.formatDateString())")
                    .font(.subheadline)
            }
            
            Spacer()
            
            if reviewsVM.isLoading {
                ProgressView()
            } else {
                ReviewInfoComponent(count: reviewsVM.reviewsList.count) {
                    if reviewsVM.reviewsList.isEmpty {
                        reviewsVM.showNoReviewsAlert.toggle()
                    } else {
                        reviewsVM.navigateToReviewsList()
                    }
                }
                .alert(locale.tvDetailsnoReviews, isPresented: $reviewsVM.showNoReviewsAlert) {}
            }
            
            navigationToReviewsList
        }.padding()
    }
    
    private var navigationToReviewsList: some View {
        NavigationLink(destination: ReviewsView(reviews: reviewsVM.reviewsList, onRefresh: {
           await reviewsVM.fetchReviews(for: tvShow.televisionID, isTv: true)
        }), isActive: $reviewsVM.navigateToReviews) {
            EmptyView()
        }
    }
}

#Preview {
    TVShowDetailsView(tvShow: DeveloperPreview.instance.tvShow)
        .environmentObject(DeveloperPreview.instance.tvShowViewModel)
        .environmentObject(DeveloperPreview.instance.reviewsViewModel)
}
