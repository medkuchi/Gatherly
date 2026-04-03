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
        func fetchEvents() async -> [Event] { //throws was here
            guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else {
                return events
            }
            
            do{
                let (data,_) = try await URLSession.shared.data(from: url)
                let decoder=JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedresponse=try decoder.decode(EventResponse.self, from:data)
                events=decodedresponse.events
                
                return events
                
            }catch{
                print("Unable to fetch events")
            }
            return events
        }
       
    }

