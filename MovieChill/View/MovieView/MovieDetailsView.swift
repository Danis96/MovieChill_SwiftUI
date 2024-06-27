//
//  MovieDetailsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 25. 6. 2024..
//

import SwiftUI

struct MovieDetailsView: View {
    
    @EnvironmentObject private var movieVM: MovieViewModel
    @EnvironmentObject private var reviewsVM: ReviewsViewModel
    let movie: Movie

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
                    
                    CreditsSectionView(credits: movieVM.returnCreditsBasedOnShowMore(), isTV: false)
                    
                }.overlay(alignment: .topLeading) {
                    xMarkButton
                }
            }.ignoresSafeArea()
        }
    }
}

extension MovieDetailsView {
    private var imageSection: some View {
        TabView {
            if let images = movie.detailsImageList {
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
    
    private var xMarkButton: some View {
        Button(action: {
            movieVM.movieSheet = nil
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
                Text("\(movie.title)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack {
                    Text(movie.voteAverage.asNumberString())
                        .font(.headline)
                    Image(systemName: "hands.clap")
                }
                
                Text("\(locale.movieDetailsReleaseDate) \(movie.releaseDate.formatDateString())")
                    .font(.subheadline)
                
            }
            .foregroundStyle(.textColor2)
            
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
                .alert(locale.movieDetailsnoReviews, isPresented: $reviewsVM.showNoReviewsAlert) {}
            }
            
            navigationToReviews
        }.padding()
    }
    
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(locale.movieDetailsOverview)
                .font(.headline)
            Text(movie.overview)
        }
        .padding()
        .foregroundStyle(.textColor2)
    }
    
    private var navigationToReviews: some View {
        NavigationLink(destination: ReviewsView(reviews: reviewsVM.reviewsList), isActive: $reviewsVM.navigateToReviews) {
            EmptyView()
        }
    }
}

#Preview {
    MovieDetailsView(movie: DeveloperPreview.instance.movie)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.reviewsViewModel)
}
