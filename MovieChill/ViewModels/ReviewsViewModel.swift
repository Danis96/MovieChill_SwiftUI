//
//  ReviewsViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation

@MainActor
class ReviewsViewModel: ObservableObject {
    
    @Published var reviewsList: [ReviewModel] = []
    @Published var showNoReviewsAlert: Bool = false
    @Published var isLoading: Bool = true
    @Published var navigateToReviews: Bool = false
    
    init() {
        self.navigateToReviews = false
        self.isLoading = false
    }
    
    private var reviewsRepository = ReviewsRepository()
    
    func fetchReviews(for id: Int, isTv: Bool = false) async {
        isLoading = true
        reviewsList.removeAll()
        do {
            let data = try await reviewsRepository.getReviews(id: id, for: isTv, type: ReviewsResultModel.self)
            self.reviewsList.append(contentsOf: data.results)
            isLoading = false
        } catch let error {
           await handleFetchError(error)
        }
    }
    

    private func handleFetchError(_ error: Error) async {
        isLoading = false
        print("Error fetching reviews: \(error.localizedDescription)")
        if let networkError = error as? NetworkError {
            print("Detailed Error: \(networkError.localizedDescription)")
        }
    }
    
    func navigateToReviewsList() {
        navigateToReviews.toggle()
    }
    
}
