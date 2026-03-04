//
//  AddEventView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/24/26.
//

import SwiftUI

struct AddEventView: View {
    @Bindable var avm=AddEventViewModel()
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("Upload Cover Photo")
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
                    
                }
            }
            
            Text("Event Title")
                .font(.title3)
                .bold()
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            TextField("", text: $avm.title)
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            HStack{
                Text("Location")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal,15)
                    .padding(.vertical,5)
            }
            
            TextField("", text: $avm.location)
                .padding(.horizontal,15)
                .padding(.vertical,5)
            
            DatePicker("Date and Time",selection:$avm.timestamp, displayedComponents: [.date,.hourAndMinute])
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
            
            TextField("", text:$avm.description, axis:.vertical)
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
                            .frame(width:200,height:50)
                        Text("Create Event")
                            .font(.title)
                            
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
                .navigationTitle(Text("Create Event"))
                          
            }
        }
        
       
                      
    }



#Preview {
    NavigationStack{
        AddEventView()
            .preferredColorScheme(.dark)
    }
}
