//
//  HomeView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/18/26.
//

import SwiftUI

struct HomeView: View {
    @State var events: [Event] = []
    @State private var vm=EventsViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                
                let columns = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
                ScrollView{
                    LazyVGrid(columns: columns, spacing:15){
                        ForEach(vm.filteredEventIndices,id: \.self) { index in
                            NavigationLink{
                                EventDetailsView(event:vm.events[index])
                            }label:{
                                CardView(event:vm.events[index])
                            }
                        }
                    }
                    
                    .navigationTitle("Home")
                    .toolbar{
                        ToolbarItem(placement:.topBarTrailing){
                            NavigationLink("+ Create Event"){
                                AddEventView()
                            }
                        }
                    }
                    .task {
                        do {
                            try await vm.fetchEvents()
                        } catch {
                            print("there was an error: \(error.localizedDescription)")
                        }
                    }
                    .searchable(text: $vm.searchfor)
                }
            }
        }
    }
}


#Preview {
    NavigationStack{
        HomeView()
            .preferredColorScheme(.dark)
    }
}
