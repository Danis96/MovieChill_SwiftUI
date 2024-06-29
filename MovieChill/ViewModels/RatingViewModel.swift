//
//  RatingViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 27. 6. 2024..
//

import Foundation

@MainActor
class RatingViewModel: ObservableObject {
    
    @Published var showRatingAddSheet: Bool = false
    @Published var showRatingSuccess: Bool = false
    @Published var isLoading: Bool = true
    @Published var ratingValue: Double = 0.0
    
    private var ratingRepository: RatingRepository?
    
    init() {
        ratingRepository = RatingRepository()
    }
    
    func postRating(id: String, isTV: Bool = false) async {
        setLoader(value: true)
        guard let ratingRepo = ratingRepository else { return  }
        
        do {
            let data = try await ratingRepo.addRating(for: id, value: ratingValue, isTV: isTV, type: ResponseModel.self)
            print("Code: \(data.statusCode)")
            print("Status msg: \(data.statusMessage)")
            setLoader(value: false)
            await handleRatingData(data: data)
        } catch let error {
            await handleFetchError(error)
        }
    }
    
    private func handleRatingData(data: ResponseModel) async {
        if data.success {
            showRatingSuccess = true
        }
    }
    

    private func handleFetchError(_ error: Error) async {
        setLoader(value: false)
        print("Error fetching reviews: \(error.localizedDescription)")
        if let networkError = error as? NetworkError {
            print("Detailed Error: \(networkError.localizedDescription)")
        }
    }
    
    private func setLoader(value: Bool) {
        isLoading = value
    }
    
}
