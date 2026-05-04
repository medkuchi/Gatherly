//
//  MapDetailView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import SwiftUI

struct MapDetailView: View {
    @Environment(\.dismiss) var dismiss
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
                                .scaledToFit()
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
            
            Text(event.location)
                .foregroundStyle(.secondary)
                .padding(.leading,10)
            Divider().overlay(.white)
            
            Text("Description")
                .font(.title3)
                .padding(.vertical,5)
                .padding(.leading,5)
            Text("\(event.description)")
                .foregroundStyle(.secondary)
            VStack{
                Spacer()

                Spacer()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
}

#Preview {
    MapDetailView(event:Event.example)
}
