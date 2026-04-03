//
//  card view.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/11/26.
//

import SwiftUI

struct CardView: View {
    let event: Event
    
    var body: some View {
        
               // VStack{
                    VStack(alignment:.leading){
                        
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
                                Rectangle()
                                    .foregroundStyle(.gray)
                        }
                        
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                }
            
        //}
        
    
}

#Preview {
    CardView(event:Event.example)
              
        .preferredColorScheme(ColorScheme.dark)
}
