//
//  CertificationsView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 30. 6. 2024..
//

import SwiftUI

struct CertificationsView: View {
    
    let certificationList: [CertificationGroup]
    var onRefresh: () async -> Void
    
    var body: some View {
        List(certificationList) { group in
            Section(header: sectionHeaderView(country: group.country)) {
                ForEach(group.certifications) { certification in
                    certificationListItem(certification: certification)
                }
            }
        }
        .refreshable {
            Task {
                await onRefresh()
            }
        }
    }
}

extension CertificationsView {
    private func sectionHeaderView(country: String) -> some View {
        HStack {
            Text("Country")
                .font(.subheadline)
            Text("\(country)")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
    
    private func certificationListItem(certification: Certification) -> some View {
        VStack(alignment: .leading) {
            Text(certification.certification)
                .font(.headline)
                .foregroundColor(.black)
            Text(certification.meaning)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
    
}

#Preview {
    CertificationsView(certificationList: DeveloperPreview.instance.certificationList, onRefresh: {
        
    })
    .environmentObject(DeveloperPreview.instance.certificationViewModel)
}
