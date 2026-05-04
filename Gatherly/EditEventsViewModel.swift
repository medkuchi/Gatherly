//
//  EditEventsViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/24/26.
//

import Foundation
import PhotosUI
import SwiftUI
import _PhotosUI_SwiftUI


@Observable

class EditEventsViewModel{
    var id = ""
    var creatorPid="730858271"
    var title=""
    var location=""
    var description=""
    var image_url=""
    var timestamp=Date()
    var loadingState: LoadingState = .idle
    var isError: Bool = false
    var errorString: String = ""

    init(event: Event) {
        id = event.id ?? ""
        title = event.title
        location = event.location
        description = event.description
        timestamp = event.timestamp
        image_url = event.image_url ?? ""
    }
    var base64String: String?
    var uiImage: UIImage?
    var image: Image? {
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    var selectedPhoto: PhotosPickerItem?
    
    
    func editevent(event: EditEventsViewModel) -> Event {
        return Event(id: event.id, creatorPid: event.creatorPid, title: event.title, location: event.location, description: event.description, image_url: event.image_url, image: event.base64String, timestamp: event.timestamp)
    }
    func loadImage() async {
        loadingState = .loading
        do{
            if let data = try await selectedPhoto?.loadTransferable(type: Data.self) {
                let uiImage = UIImage(data: data)
                self.uiImage = uiImage
                loadingState = .success
            }
        } catch let error as ErrorType{
                loadingState = .failed(error)
                isError = true
                errorString = error.localizedDescription
            } catch{
                loadingState = .failed(.unknown)
                isError = true
                errorString = error.localizedDescription
            }
        }
    func editEvent() async throws {
        loadingState = .loading
        do{
            try await EventService.shared.editEvent(id: id, title: title, description: description, timestamp: timestamp, location: location, uiImage: uiImage)
            loadingState = .success
        }
        catch  let error as ErrorType {
            loadingState = .failed(error)
            isError = true
            errorString = error.localizedDescription
        }
        catch{
            loadingState = .failed(.unknown)
            isError = true
            errorString = error.localizedDescription
        }
        }

    }
    
   

