//
//  HomeView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/18/26.
//

import SwiftUI

struct HomeView: View {
    @State var events: [Event] = []
    var body: some View {
        VStack{
            ForEach(events,id: \.id) { event in
                
                NavigationLink{
                    EventDetailsView(event:event)
                }label:{
                    CardView(event:event)
                }
            }
        }
        
        .navigationTitle("Home")
        .task{
            do{
                events=try await fetchEvents()
            }catch{
                print("Unable to fetch events")
            }
        }
    }
}


func fetchEvents() async throws->[Event]{
    guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else {
        throw URLError(.badURL)
    }
    let URLSession = URLSession.shared
    let (data,_) = try await URLSession.data(from: url)
    let decoder=JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let decodedresponse=try decoder.decode(EventResponse.self, from:data)
    
    return decodedresponse.events
}

#Preview {
    NavigationStack{
        HomeView()
            .preferredColorScheme(.dark)
    }
}
