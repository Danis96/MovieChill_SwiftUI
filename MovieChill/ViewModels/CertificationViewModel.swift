//
//  CertificationViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 29. 6. 2024..
//

import Foundation


@MainActor
class CertificationViewModel: ObservableObject {
    
    @Published var certificationList: [CertificationGroup] = []
    @Published var navigateToCertifications: Bool = false
    @Published var isLoading: Bool = false
    
    private var certificationRepository: CertificationRepository?
    
    init() {
        self.certificationRepository = CertificationRepository()
    }
    
    func fetchCertifications(forTV isTV: Bool = false) async {
        setLoading(value: true)
        guard let certRepo = certificationRepository else { return  }
        
        do {
            let data = try await certRepo.getCertificates(type: CertificationsData.self)
            await handleData(data: data)
        } catch let error {
            await handleFetchError(error)
        }
        
    }
    
    private func handleData(data: CertificationsData) async {
        self.certificationList = data.certifications.map { country, certifications in
            CertificationGroup(certifications: certifications, country: country)
        }.sorted { $0.country < $1.country }
        setLoading(value: false)
    }
    
    
    private func handleFetchError(_ error: Error) async {
        print("Error fetching certification: \(error.localizedDescription)")
        if let networkError = error as? NetworkError {
            print("Detailed Error: \(networkError.localizedDescription)")
        }
        setLoading(value: true)
    }
    
    func navigateToCertificationsList() {
        navigateToCertifications.toggle()
    }
    
    private func setLoading(value: Bool) {
        isLoading = value
    }
    
    
    
}
