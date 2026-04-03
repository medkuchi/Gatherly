//
//  EditEventView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/17/26.
//

import SwiftUI
import PhotosUI

struct EditEventView: View {
    @Bindable var evm=EditEventsViewModel()
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("Change Cover Photo")
                    .bold()
                    .font(.title3)
                    .padding(.horizontal,15)
                    .padding(.vertical,15)
                Spacer()
            }
            HStack{
                PhotosPicker(selection: $evm.selectedPhoto, matching: .images) {
                    Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
                    .padding(20)
                    .background(.thinMaterial)
                }
                .task(id: evm.selectedPhoto) {
                    await evm.loadImage()
                }
                evm.image?
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
            }
            Text("Event Title")
                .font(.title3)
                .bold()
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            TextField("", text: $evm.title)
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            HStack{
                Text("Location")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
            }
            
            TextField("", text: $evm.location)
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            DatePicker("Date and Time",selection:$evm.timestamp, displayedComponents: [.date,.hourAndMinute])
                .font(.title3)
                .bold()
            
                .padding(.horizontal,15)
                .padding(.vertical,5)

            HStack{
                Text("Event Description")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,15)
            }
            
            TextField("", text: $evm.description, axis:.vertical)
                .padding(.horizontal,15)
            Text("_____________________________________________")
            Spacer()
            HStack{
                Spacer()
                Button{
                    Task{
                        try await EventService.shared.createEvent(title: evm.title, description: evm.description, timestamp: evm.timestamp, location: evm.location, uiImage:evm.uiImage)
                    }
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius:10)
                            .stroke(Color.cyan, lineWidth:1)
                            .frame(width:150,height:50)
                        Text("Save")
                            .font(.title)
                            //.foregroundStyle(.white)
                            .bold()
                    }
                    
                }
                .padding(.horizontal)
                Spacer()
            }
                      Spacer()
                      
                .toolbar{
                    ToolbarItem(placement:.topBarLeading){
                        Button{
                            
                        }label:{
                            Text("Cancel")
                        }
                        
                    }
                }
                .navigationTitle(Text("Edit Event"))
                      //.alignmentGuide(.horizontal)
                      
                      
        }
    }
}
#Preview {
    NavigationStack{
        EditEventView()
            .preferredColorScheme(.dark)
    }
}
