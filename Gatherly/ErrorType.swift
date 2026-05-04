//
//  ErrorType.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 4/2/26.
//

import Foundation

enum ErrorType: LocalizedError {
    case networkError
    case codingError
    case invalidURL
    case unknown
    case mapError
    case geocodingError

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "A network error occurred. Please check your connection."
        case .codingError:
            return "Failed to encode/decode data."
        case .invalidURL:
            return "The URL provided is invalid."
        case .unknown:
            return "An unknown error occurred."
        case .mapError:
            return "Failed to load map/map error."
        case .geocodingError:
            return "Failed to geocode addresses."
        }
    }
}
