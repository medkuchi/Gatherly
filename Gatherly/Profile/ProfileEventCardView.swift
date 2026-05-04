//
//  ProfileEventCardView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import SwiftUI

struct ProfileEventCardView: View {
    let rsvpEvent : RSVPedEvent
    var body: some View {
        
               // VStack{
        VStack(alignment:.leading){
            HStack{
                if let imageEvent = rsvpEvent.image_url {
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
                                    .frame(width:120, height:60)
                                    .clipped()
                                
                                // if loading the image fails, show gray box
                            case .failure:
                                Rectangle()
                                    .foregroundStyle(.gray)
                                    .frame(width:120, height:60)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                    } else {
                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width:120,height:60)
                    }
                    VStack(alignment:.leading){
                        Text(rsvpEvent.title)
                            .bold()
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        Text(rsvpEvent.timestamp, format: .dateTime.month(.abbreviated).day().year())
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 10)
                            .padding(.bottom,10)
                        Text(rsvpEvent.location)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 10)
                            .padding(.bottom,10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    
                }
            }
                    }
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                }

    
}

#Preview {
    ProfileEventCardView(rsvpEvent:RSVPedEvent.rsvpExample)
}
