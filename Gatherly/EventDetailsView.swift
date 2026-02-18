//
//  EventCardView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/17/26.
//

import SwiftUI

struct EventDetailsView: View {
    @State private var isShowingDialog = false
    let event:Event
    var body: some View {
        
        VStack(alignment:.leading){
            
            HStack{
                Spacer()
                Text("Event Details")
                    .font(.title)
                Spacer()
                
            }
           
            Image("Sunset.jpg")
                .resizable()
                .frame(width: 400, height: 300)
            Text("Conference")
                .font(.title)
                .bold()
                .padding(.leading,10)
                .padding(.vertical,3)
            
            
            HStack{
                Text("Aug 6,2025")
                    .foregroundStyle(.secondary)
                    .padding(.leading, 10)
                Image(systemName:"circle.fill")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.leading,10)
                Text("1:00 PM")
                    .foregroundStyle(.secondary)
                    .padding(.leading, 10)
                    .padding(.vertical,3)
            }
            
            Text("Charlotte Convention Center, Charlotte, NC")
                .foregroundStyle(.secondary)
                .padding(.leading,10)
            Text("__________________________________________")
                .padding(.leading,10)
            
            Text("Description")
                .font(.title3)
                .padding(.vertical,5)
                .padding(.leading,5)
            Text("-------------Add in description here -------------- ")
                .foregroundStyle(.secondary)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        
                    }label:{
                        Text("RSVP")
                            .font(.title)
                            .foregroundStyle(.white)
                            .bold()
                            .clipShape(RoundedRectangle(cornerRadius:20))
                        // ,stroke(Color.white, lineWidth: 2)
                        //add cyan outline
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
                    
                }
                label:{
                    Image(systemName:"chevron.left") //add .topBarTrailing
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
            
            ToolbarItem(placement:.topBarTrailing){
                Button{
                    isShowingDialog=true
                }label:{
                    Image(systemName:"ellipsis")}
                .foregroundStyle(.white)
                .font(.title)
                .padding(.trailing,10)
                
            }
        }
        .confirmationDialog("Delete", isPresented: $isShowingDialog, titleVisibility: .visible){
            Button("Delete", role: .destructive){
                
            }
            Button("Cancel", role: .cancel){
                isShowingDialog=false
            }
        } message: {
            Text("Do you want to delete this event?")
        }
    }
    
}
#Preview {
    NavigationStack{
        EventDetailsView(event:Event.example)
            .preferredColorScheme(ColorScheme.dark)
    }

}
