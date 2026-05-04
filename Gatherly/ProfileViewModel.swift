//
//  ProfileViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/4/26.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

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
}
