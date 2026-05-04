//
//  ProfileViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/4/26.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import SwiftData

@Observable
class ProfileViewModel {
    let tabs = ["My Events", "Past Events"]
    var selectedTab: String = "My Events"
    var selectedPhoto: PhotosPickerItem?

    func selectTab(tab: String) {
        selectedTab = tab
        filterEvents()
    }
    
    func filterEvents() {
        // doesn't need to work for now
    }
    
    func loadImage(profile:UserProfile, modelContext:ModelContext) async{
        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
            profile.userPicture = data
            try? modelContext.save()
        }
    }
}
