//
//  EventsViewModel.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/19/26.
//

import Foundation

@Observable
class EventsViewModel{
    var events:[Event]=[]
    var searchfor:String = ""
    var filteredEventIndices:[Int] {
        events.indices.filter { i in
        searchfor.isEmpty || events[i].title.localizedCaseInsensitiveContains(searchfor)
    }
    }
        func fetchEvents() async throws -> [Int] {
            guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else {
                return filteredEventIndices
            }
            
            do{
                let URLSession = URLSession.shared
                let (data,_) = try await URLSession.data(from: url)
                let decoder=JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedresponse=try decoder.decode(EventResponse.self, from:data)
                events=decodedresponse.events
                
                return filteredEventIndices
                
            }catch{
                print("Unable to fetch events")
                return filteredEventIndices
            }
        }
       
    }

