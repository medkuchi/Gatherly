//
//  EditEventsViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/24/26.
//

import Foundation

@Observable

class EditEventsViewModel{
    var id = ""
    var creatorPid="730858271"
    var title=""
    var location=""
    var description=""
    var image_url=""
    var image=""
    var timestamp=Date()
}

func editevent(event: EditEventsViewModel) -> Event {
    return Event(id: event.id, creatorPid: event.creatorPid, title: event.title, location: event.location, description: event.description, image_url: event.image_url, image: event.image, timestamp: event.timestamp)
}
