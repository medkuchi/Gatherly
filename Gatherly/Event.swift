//
//  Event.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/11/26.
//

import Foundation

struct Event: Hashable, Identifiable, Codable{
    var id: String?
    var creatorPid: String="730858271"
    var title: String
    var location: String
    var description: String
    var image_url: String?
    var image:String?
    var timestamp: Date
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
