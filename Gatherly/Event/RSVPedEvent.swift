//
//  RSVPedEvent.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import Foundation
import SwiftData

@Model
class RSVPedEvent {
    @Attribute(.unique) var id: String
    var title: String
    var location: String
    var creatorPid: String
    var eventDescription: String
    var timestamp: Date
    var image_url: String?
    
    init(id: String, title: String, location: String, creatorPid: String, eventDescription: String, timestamp: Date, image_url: String?) {
        self.id = id
        self.title = title
        self.location = location
        self.creatorPid = creatorPid
        self.eventDescription = eventDescription
        self.timestamp = timestamp
        self.image_url = image_url
    }
}
extension RSVPedEvent {
    static var rsvpExample: RSVPedEvent =
        RSVPedEvent(
            id: "1",
            title: "Sunset Concert",
            location: "Student Union Ballroom",
            creatorPid: "730858271",
            eventDescription: "Join fellow students for a night of collaborative coding, snacks, and fun.",
            timestamp: Date(),
           image_url:"Sunset"
        )
}
