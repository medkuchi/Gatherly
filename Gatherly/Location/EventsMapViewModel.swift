//
//  EventsMapViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import Foundation

import Observation
import MapKit

@Observable
class EventsMapViewModel {
    var events: [Event] = []
    var annotations: [EventAnnotation] = []
    private var geocode=CLGeocoder()

    
    func load() async throws {
        do {
            let response = try await EventService.shared.fetchEvents()
            self.events = response
                
        let addressEvents = response.filter { !$0.location.isEmpty }
                            
        annotations.removeAll()
        for event in addressEvents {
            if let coordinate = try await geocode(event.location) {
              annotations.append(EventAnnotation(id: event.id ?? UUID().uuidString,
                                               event: event,
                                               coordinate: coordinate)
                                               )
          }
        }
      } catch {
            // TODO: add new error to your ErrorType from Ticket 3
        // throw this error
          throw ErrorType.mapError
          
      }
    }
    
    private func geocode(_ address: String) async throws -> CLLocationCoordinate2D? {
        await withCheckedContinuation { continuation in
            geocode.geocodeAddressString(address) { place, _ in
                let coordinate = place?.first?.location?.coordinate
              continuation.resume(returning: coordinate)
        }
      }
    }
    
    
}
