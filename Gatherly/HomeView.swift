//
//  HomeView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/18/26.
//

import SwiftUI

struct HomeView: View {
    @Bindable var vm: EventsViewModel
    let columns = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
    
    var body: some View {
        NavigationStack{
            VStack{
                switch vm.loadingState {
                case .loading:
                    ProgressView("Loading events...")
                case .failed(let errorType):
                    ContentUnavailableView {
                        Label("Something went wrong", systemImage: "x.circle.fill")
                    } description: {
                        Text(errorType.localizedDescription)
                    }
                case .idle, .success:
                    HStack{
                        Spacer()
                        NavigationLink{
                            AddEventView()
                        }label:{
                            Text("+ Create Event")
                        }
                        
                    }
                    .padding(.trailing,15)
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(vm.filteredEventIndices, id: \.self) { index in
                                NavigationLink {
                                    EventDetailsView(event: vm.events[index])
                                } label: {
                                    CardView(event: vm.events[index])
                                }
                            }
                        }
                    }
                    .refreshable {
                        await vm.fetchEvents()
                        //Edited events were not shwoing up because the page wasnt being refreshed so added this so it fetches events again. On appear wasnt working either.
                    }
                }
            }
            
            .task {
                await vm.fetchEvents()
            }
            .searchable(text: $vm.searchfor)
            .alert("Failed to Fetch Events", isPresented: $vm.isError){
                Button("OK", role: .cancel){}
            } message:{
                Text(vm.errorString)
            }
        }
        }
       
        
    }



//var body: some View {
//    NavigationStack{
//        VStack{
//            
//            let columns = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
//            NavigationLink{
//                AddEventView()
//            }label:{
//                Text("+ Create Event")
//            }
//            ScrollView{
//                LazyVGrid(columns: columns, spacing:15){
//                    ForEach(vm.filteredEventIndices,id: \.self) { index in
//                        NavigationLink{
//                            EventDetailsView(event:vm.events[index])
//                        }label:{
//                            CardView(event:vm.events[index])
//                        }
//                    }
//                }
//                
//                //.navigationTitle("Home")
//                .task {
//                        await vm.fetchEvents()
//                    }
//                }
//                .searchable(text: $vm.searchfor)
//            }
//        }
//    }
//}



#Preview {
    NavigationStack{
        HomeView(vm:EventsViewModel())
            .preferredColorScheme(.dark)
    }
}
