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
    var loadingState: LoadingState = .idle
    var isError: Bool = false
    var errorString: String = ""
    
    
    
    
    func addnewevent(event: AddEventViewModel) -> Event {
        return Event(id: event.id, creatorPid: event.creatorPid, title: event.title, location: event.location, description: event.description, image_url: event.image_url, image: event.base64String, timestamp: event.timestamp)
    }
    func loadImage() async {
        guard selectedPhoto != nil else { return }
        do{
            if let data = try await selectedPhoto?.loadTransferable(type: Data.self) {
                let uiImage = UIImage(data: data)
                self.uiImage = uiImage
                loadingState = .success
            } 
            else {
                loadingState = .idle
            }
        } catch  let error as ErrorType {
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
//    func loadImage() async{
//        do{
//            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
//                let uiImage = UIImage(data: data)
//            }
//        }
//    }
    func createEvent() async throws {
        loadingState = .loading
        do{
            try await EventService.shared.createEvent(title: title, description: description, timestamp: timestamp, location: location, uiImage: uiImage)
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

