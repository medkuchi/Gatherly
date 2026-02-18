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
        
            HStack{
                ZStack{
                    VStack(alignment:.leading){
                        
                        Image("Sunset.png")
                            .resizable()
                            .frame(width: 200, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        VStack(alignment:.leading){
                          
                                Text("Title")
                                Text("Date")
                                    .foregroundStyle(.secondary)
                            //.background(.regularMaterial)
                                .frame(width:200, height:50)
                            
                        }
                    }
                    
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
            
            Spacer()
        }
        
    }
}

#Preview {
    CardView(event:Event.example)
              
        .preferredColorScheme(ColorScheme.dark)
}
