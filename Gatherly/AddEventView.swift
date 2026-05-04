//
//  AddEventView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/24/26.
//

import SwiftUI
import PhotosUI

struct AddEventView: View {
    @Bindable var vm=AddEventViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment:.leading){
            switch vm.loadingState {
            case .loading:
                ProgressView("Loading Events...")
            case .failed(let errorType):
                ContentUnavailableView{
                    Label("Something went wrong",systemImage: "x.circle.fill")
                } description: {
                    Text(errorType.localizedDescription)
                }
            case .idle, .success:
                HStack{
                    Text("Upload Cover Photo")
                        .bold()
                        .font(.title3)
                        .padding(.horizontal,15)
                        .padding(.vertical,15)
                    Spacer()
                }
                HStack {
                    PhotosPicker(selection: $vm.selectedPhoto, matching: .images) {
                        Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                        .padding(20)
                        .background(.thinMaterial)
                    }
                    .padding(.horizontal,15)
                    .task(id: vm.selectedPhoto) {
                        await vm.loadImage()
                    }
                    vm.image?
                        .resizable()
                        .scaledToFit()
                        .frame(height: 75)
                }
                
                Text("Event Title")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                
                TextField("Enter event title", text: $vm.title)
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                Divider().overlay(.gray)
                    Text("Location")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal,15)
                        .padding(.vertical,5)
                
                
                TextField("Choose location of event", text: $vm.location)
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                Divider().overlay(.gray)
                
                Text("Date and Time")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,5)

                DatePicker("Date and Time",selection:$vm.timestamp, displayedComponents: [.date,.hourAndMinute])
                    .font(.title3)
                    .bold()
                    .labelsHidden()
                
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
                Divider().overlay(.gray)

                    Text("Event Description")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal,15)
                        .padding(.vertical,15)
                
                
                TextField("Enter Event Description", text:$vm.description, axis:.vertical)
                    .padding(.horizontal,15)
                Divider().overlay(.gray)
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        Task{
                            try await vm.createEvent()
                            dismiss()
                        }
                        
                    }label:{
                            Text("Create Event")
                            .font(.title3)
                                      .fontWeight(.semibold)
                                      .padding(.horizontal, 28)
                                      .padding(.vertical, 8)
                                      .overlay(
                                           RoundedRectangle(cornerRadius: 9)
                                                .stroke(.cyan, lineWidth: 1)
                                       )
                            }
                            .buttonStyle(.plain)
                        
                        
                    }
                    .padding(.horizontal)
                    Spacer()
            }
            
            
            } //VStack ends
            .toolbar{
                ToolbarItem(placement:.topBarLeading){
                    Button{
                        dismiss()
                    }label:{
                        Text("Cancel")
                    }
                    
                    }
                }
                .navigationTitle(Text("Create Event"))
                .navigationBarTitleDisplayMode(.inline)
                .alert("Failed to Add Event", isPresented: $vm.isError){
                    Button("OK", role: .cancel){}
                }message:{
                    Text(vm.errorString)
                }
            }
        }
        
       
                      
    



#Preview {
    NavigationStack{
        AddEventView()
            .preferredColorScheme(.dark)
    }
}
