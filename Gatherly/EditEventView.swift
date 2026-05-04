//
//  EditEventView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/17/26.
//

import SwiftUI
import PhotosUI

struct EditEventView: View {
    let event: Event
    @Bindable var evm: EditEventsViewModel
    @Environment(\.dismiss) var dismiss

    init(event: Event) {
        self.event = event
        self.evm = EditEventsViewModel(event: event)
    }
    var body: some View {
        VStack(alignment:.leading){
            switch evm.loadingState{
            case .loading:
                ProgressView("Loading Event...")
            case .failed(let errorType):
                ContentUnavailableView{
                    Label("Something went wrong", systemImage:"x.circle.fill")
                } description: {
                    Text(errorType.localizedDescription)
                }
            case .idle, .success:
                HStack{
                    Text("Change Cover Photo")
                        .bold()
                        .font(.title3)
                        .padding(.horizontal,15)
                        .padding(.vertical,15)
                    Spacer()
                }
                //HStack{
                PhotosPicker(selection: $evm.selectedPhoto, matching: .images) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                        .padding(20)
                        .background(.thinMaterial)
                }
                .padding(.horizontal,15)
                .task(id: evm.selectedPhoto) {
                    await evm.loadImage()
                }
                evm.image?
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
                
                Text("Event Title")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                
                TextField("Write your event's title", text: $evm.title)
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                
                HStack{
                    Text("Location")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal,15)
                        .padding(.vertical,5)
                }
                
                TextField("Choose location of event", text: $evm.location)
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
                
                TextField("Write a description for your event", text: $evm.description, axis:.vertical)
                    .padding(.horizontal,15)
                Divider().overlay(.gray)
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        Task{
                            try await evm.editEvent()
                            dismiss()
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
                
            }
        }
                .toolbar{
                    ToolbarItem(placement:.topBarLeading){
                        Button{
                            dismiss()
                        }label:{
                            Text("Cancel")
                        }
                        
                    }
                }
        
            .navigationTitle(Text("Edit Event"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
                  //.alignmentGuide(.horizontal)
            .alert("Failed to Edit Event", isPresented: $evm.isError){
                Button("OK", role: .cancel){}
            }message:{
                Text(evm.errorString)
            }
                      
         //VStack ends here
    }
}
#Preview {
    NavigationStack{
        EditEventView(event: Event.example)
            .preferredColorScheme(.dark)
    }
}
