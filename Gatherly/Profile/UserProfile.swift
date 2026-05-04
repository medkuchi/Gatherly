//
//  UserProfile.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import Foundation
import SwiftData

@Model
class UserProfile {
    var userPicture: Data?
    
    init(userPicture: Data? = nil) {
        self.userPicture = userPicture
    }
}
