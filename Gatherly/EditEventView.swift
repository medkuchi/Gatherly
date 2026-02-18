//
//  EditEventView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/17/26.
//

import SwiftUI

struct EditEventView: View {
    @State var event:Event
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
                        if let ImageName=event.image_url{
                            Image(ImageName)
                                .resizable()
                                .frame(width:100,height:100)
                        }
                    }
                }
            }
            Text("Event Title")
                .font(.title3)
                .bold()
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            TextField("", text: $event.title)
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            HStack{
                Text("Location")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
            }
            
            TextField("", text: $event.location)
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
                DatePicker("Date and Time",selection:$event.timestamp, displayedComponents: [.date,.hourAndMinute])
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
            
            TextField("", text: $event.description, axis:.vertical)
                .padding(.horizontal,15)
            Text("_____________________________________________")
            Spacer()
            HStack{
                Spacer()
                Button{
                    
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius:10)
                            .stroke(Color.cyan, lineWidth:1)
                            .frame(width:150,height:50)
                        Text("Save")
                            .font(.title)
                            .foregroundStyle(.white)
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
        EditEventView(event:Event.example)
            .preferredColorScheme(.dark)
    }
}
