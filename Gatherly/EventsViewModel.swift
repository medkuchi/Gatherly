//
//  EventsViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/19/26.
//

import Foundation
import Observation

@Observable
class EventsViewModel {
    var events: [Event] = []
    var loadingState: LoadingState = .idle
    var searchfor: String = ""
    var filteredEventIndices: [Int] {
        events.indices.filter { i in
            searchfor.isEmpty || events[i].title.localizedCaseInsensitiveContains(searchfor)}
    }
    var isError: Bool = false
    var errorString: String = ""

    func fetchEvents() async {
        loadingState = .loading
        do {
            let fetched = try await EventService.shared.fetchEvents()
          events = fetched
          loadingState = .success
        } catch let error as ErrorType {
            loadingState = .failed(error)
            isError = true
            errorString = error.localizedDescription
            
        } catch {
            loadingState = .failed(.unknown)
        }
    }
}

