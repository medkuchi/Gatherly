//
//  Event.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/11/26.
//

import Foundation
import CoreLocation

struct Event: Hashable, Identifiable, Codable{
    var id: String?
    var creatorPid: String="730858271"
    var title: String
    var location: String
    var description: String
    // only used for decoding GET requests and showing an Async Image
    var image_url: String?
    
    // only used for encoding for POST or PUT requests
    var image: String?
    var timestamp: Date
}

struct EventAnnotation: Identifiable{
    var id:String
    var event: Event
    var coordinate: CLLocationCoordinate2D
}

extension Event {
    static var example: Event =
        Event(
            title: "Sunset Concert",
            location: "Student Union Ballroom",
            description: "Join fellow students for a night of collaborative coding, snacks, and fun.",
            image_url:"Sunset",
            timestamp: Date()
        )
}
