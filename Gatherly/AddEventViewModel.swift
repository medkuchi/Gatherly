//
//  AddEventViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/1/26.
//

import Foundation
import PhotosUI
import SwiftUI
//import _PhotosUI_SwiftUI


@Observable
//AddEventViewModel avm=AddEventViewModel()
class AddEventViewModel {
    var id = ""
    var creatorPid="730858271"
    var title=""
    var location=""
    var description=""
    var image_url=""
    //var image=""
    var timestamp=Date()
    var base64String: String?
    var uiImage: UIImage?
    var image: Image? {
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    var selectedPhoto: PhotosPickerItem?
    
    
    
    func addnewevent(event: AddEventViewModel) -> Event {
        return Event(id: event.id, creatorPid: event.creatorPid, title: event.title, location: event.location, description: event.description, image_url: event.image_url, image: event.base64String, timestamp: event.timestamp)
    }
    func loadImage() async {
        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
            let uiImage = UIImage(data: data)
            self.uiImage = uiImage
        }
    }
}

