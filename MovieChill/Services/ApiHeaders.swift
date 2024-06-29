//
//  ApiHeaders.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation

enum APIHEADERS {
    case json_token
    case app_json
}

class ApiHeaders {
    
    func getValue(type: APIHEADERS, concatValue: String = "") -> [String : String] {
        switch type {
        case .json_token:
            return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZmZjYjQ5MDczMDA3ZWNkZTZiMzRjOTEyNTAzOTU4NCIsIm5iZiI6MTcxOTE3MjIxMC45NDAxNDYsInN1YiI6IjYyMzI0MTRmODNlZTY3MDAxYjI0OTkwYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jmJETuMM7QTCcw5UdOyNf1U4RiLPq50p1ika2BVBD3c"
            ]
        case .app_json:
            return [
                "accept": "application/json",
                "Content-Type": "application/json;charset=utf-8",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZmZjYjQ5MDczMDA3ZWNkZTZiMzRjOTEyNTAzOTU4NCIsIm5iZiI6MTcxOTE3MjIzOS4xMjgxNjEsInN1YiI6IjYyMzI0MTRmODNlZTY3MDAxYjI0OTkwYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ryv6MECdU2gO5FtOzScRFZ75fjKvnURmaPAdAE6SS28"
            ]
        }
    }
}
