//
//  EventCardView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/17/26.
//

import SwiftUI
import SwiftData

struct EventDetailsView: View {
    @State private var isShowingDialog = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    let event:Event
    var body: some View {
        
        VStack(alignment:.leading){
            
           
            // check to see if event's image_url property is nil since it's an optional
            if let imageEvent = event.image_url {
                // checks to see if image_url is actually a URL
                if let url = URL(string: imageEvent) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        // when loading, it shows spinner (ProgressView())
                        case .empty:
                            ProgressView()
                        // if loads successfully, shows image, sets it to resizable, and is scaled to Fit
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth:.infinity)
                        // if loading the image fails, show gray box
                        case .failure:
                            Rectangle()
                            .foregroundStyle(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            } else {
                    // if no image_url property, placeholder is gray box
                    Rectangle()
                        .foregroundStyle(.gray)
            }
            Text(event.title)
                .font(.title)
                .bold()
                .padding(.leading,10)
                .padding(.vertical,3)
            
            
            HStack{
                Text(event.timestamp, format: .dateTime.month(.abbreviated).day().year())
                    .foregroundStyle(.secondary)
                    .padding(.leading, 10)
                Image(systemName:"circle.fill")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.leading,10)
                Text(event.timestamp, format: .dateTime.hour().minute())
                    .foregroundStyle(.secondary)
                    .padding(.leading, 10)
                    .padding(.vertical,3)
            }
            
            Text(event.location)
                .foregroundStyle(.secondary)
                .padding(.leading,10)
            Divider().overlay(.white)
            
            Text("Description")
                .font(.title3)
                .padding(.vertical,5)
                .padding(.leading,10)
            Text("\(event.description)")
                .foregroundStyle(.secondary)
                .padding(.leading,10)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        let rsvp = RSVPedEvent(id: event.id ?? UUID().uuidString,  title: event.title, location: event.location, creatorPid: event.creatorPid, eventDescription: event.description, timestamp: event.timestamp, image_url: event.image_url)
                        modelContext.insert(rsvp)
                        try? modelContext.save()
                        dismiss()
                        
                    } label: {
                        ZStack{
                            
                            Text("RSVP")
                                .font(.title)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius:20))
                                .overlay(
                                     RoundedRectangle(cornerRadius: 9)
                                          .stroke(.cyan, lineWidth: 1)
                                          .frame(width:120,height:50)
                                )
                            //.stroke(Color.white, lineWidth:1)
                            //add cyan outline
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement:.topBarLeading){
                Button{
                    dismiss()
                }
                label:{
                    Image(systemName:"chevron.left") //add .topBarTrailing
                }
            }
            
            ToolbarItem(placement:.topBarTrailing){
                Button{
                    isShowingDialog = true
                }label:{
                    Image(systemName:"ellipsis")}
                //.foregroundStyle(.white)
        
            }
        }
        .confirmationDialog("Advanced Actions", isPresented: $isShowingDialog, titleVisibility: .visible) {
            NavigationLink("Edit Event"){
                EditEventView(event: event)
            }
            Button("Delete Event", role:.destructive){
                Task{
                    try await EventService.shared.deleteEvent(id:event.id ?? "")
                    dismiss()
                }
                
            }
        } message: {
            Text("Make changes to your event")
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}
#Preview {
    NavigationStack{
        EventDetailsView(event:Event.example)
            .preferredColorScheme(ColorScheme.dark)
    }

}
