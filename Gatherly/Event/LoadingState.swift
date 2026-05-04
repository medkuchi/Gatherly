//
//  LoadingState.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case success
    case failed(ErrorType)
}

