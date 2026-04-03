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
                Button{
                    AddEventView()
                }label:{
                    Text("+ Create Event")
                }
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
                    
                    //.navigationTitle("Home")
                    .task {
                        do {
                            vm.events=try await vm.fetchEvents()
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
