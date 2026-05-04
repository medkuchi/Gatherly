//
//  ContentView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                HomeView(vm: EventsViewModel())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                EventMapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                NavigationStack{
                    ProfileView()
                }
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        
    }
    }

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
