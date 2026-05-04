//
//  ProfileView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/4/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ProfileView: View {
    @Bindable var vm = ProfileViewModel()
    @Query var upcomingEvents: [RSVPedEvent]
    @Query var pastEvents: [RSVPedEvent]
    @Query var profiles: [UserProfile]
    @Environment(\.modelContext) private var modelContext
    
    init() {
        let now = Date.now
        _upcomingEvents = Query(
          filter: #Predicate { event in
            event.timestamp >= now
        }
      )
      _pastEvents = Query(
          filter: #Predicate { event in
            event.timestamp < now
            }
        )
    }
    var profile: UserProfile{
        if let existing = profiles.first{
            return existing
        }
        let newProfile = UserProfile()
        modelContext.insert(newProfile)
        return newProfile
    }
    
    var body: some View {
        VStack{
            PhotosPicker(selection:$vm.selectedPhoto,matching: .images){
                if let data = profile.userPicture, let uiImage = UIImage(data: data){
                    Image(uiImage:uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width:100,height:100)
                        .clipShape(Circle())
                }
                else{
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .padding(28)
                        .background(
                            Circle()
                                .fill(.thinMaterial)
                        )
                        .frame(width: 100)
                    
                        .padding(.horizontal,15)
                }
            }
            .task(id: vm.selectedPhoto){
                await vm.loadImage(profile: profile, modelContext: modelContext)
            }
            
            .padding(10)
                    Text("John Smith")
                        .bold()
                .padding(20)
            
            HStack(spacing: 0) {
                ForEach(vm.tabs, id: \.self) { tab in
                    Button {
                        vm.selectTab(tab: tab)
                    } label: {
                        VStack {
                            Text(tab)
                                .foregroundStyle(.primary)
                            Rectangle()
                                .fill(vm.selectedTab == tab ? .cyan : .primary)
                                .frame(height: 2)
                                .padding(.top, 4)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            if vm.selectedTab == "My Events"{
                List{
                    ForEach(upcomingEvents) { event in
                        NavigationLink {
                              MapDetailView(event: Event(
                                  id: event.id,
                                  creatorPid: event.creatorPid,
                                  title: event.title,
                                  location: event.location,
                                  description: event.eventDescription,
                                  image_url: event.image_url,
                                  timestamp: event.timestamp
                              ))
                          } label: {
                              ProfileEventCardView(rsvpEvent: event)
                              }
                       
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete(upcomingEvents[index])
                        }
                    }
                }
                
            }
            if vm.selectedTab == "Past Events"{
                List{
                    ForEach(pastEvents) { event in
                        NavigationLink {
                            MapDetailView(event: Event(
                                id: event.id,
                                creatorPid: event.creatorPid,
                                title: event.title,
                                location: event.location,
                                description: event.eventDescription,
                                image_url: event.image_url,
                                timestamp: event.timestamp
                            ))
                        } label: {
                            ProfileEventCardView(rsvpEvent: event)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete(pastEvents[index])
                        }
                }
                
                    }
                }
                
            }
        
        //.padding(20)
        
        
        //.padding(.leading,30)
        //        .navigationTitle(Text("Profile"))
        
        
        Spacer()
        
        
    }
    }


#Preview {
//    NavigationStack{
        ProfileView()
//    }
}
