//
//  ReviewsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 27. 6. 2024..
//

import SwiftUI

struct ReviewsView: View {
    
    let reviews: [ReviewModel]
    let onRefresh: () async -> Void
    
    var body: some View {
        ScrollView {
            ForEach(reviews) { review in
                reviewItem(review: review)
            }
        }
        .refreshable {
            Task {
                await onRefresh()
            }
        }
    }
}

extension ReviewsView {
    private func reviewItem(review: ReviewModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(review.author)
                    .font(.title2)
                .fontWeight(.bold)
                Spacer()
                if let rating = review.authorDetails.rating {
                    HStack {
                        Text("\(rating)")
                            .font(.subheadline)
                        Image(systemName: "hands.clap.fill")
                    }
                }
            }
            Text(review.content)
            buttonUrl(url: review.url)
        }.frame(maxWidth: .infinity)
            .padding()
    }
    
    private func buttonUrl(url: String) -> some View {
        VStack {
            if let urlLink = URL(string: url) {
                Link(destination: urlLink, label: {
                    Text(LocaleStrings().reviewsReadMore)
                })
                .tint(.blue)
            }
        }
    }
}

#Preview {
    ReviewsView(reviews: DeveloperPreview.instance.reviewsList) {
        print("ON REFRESH")
    }
}
