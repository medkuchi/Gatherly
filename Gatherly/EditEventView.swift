//
//  EditEventView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/17/26.
//

import SwiftUI

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
                Button{
                    
                }
                label:{
                    ZStack{
                        RoundedRectangle(cornerRadius:0)
                            .stroke(Color.gray, lineWidth:1)
                            .frame(width:100,height:100)
                        
                        Image(systemName:"plus")
                            .font(.largeTitle)
                    }
                    .padding(.horizontal,15)
                }
                Button{
                }
                label:{
                    ZStack{
                        RoundedRectangle(cornerRadius:0)
                            .stroke(Color.gray, lineWidth:1)
                            .frame(width:100,height:100)
//                        if let ImageName=$image_url{
//                            Image(ImageName)
//                                .resizable()
//                                .frame(width:100,height:100)
//                        }
                        Image("\($evm.image_url)")
                            .resizable()
                            .frame(width:100,height:100)
                    }
                }
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
                    //let newevent=Event(title:$evm.title, location: $evm.location, description: $evm.description, image_url:$evm.image_url, timestamp: $evm.timestamp)
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
