//
//  ProfileView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/4/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Bindable var vm = ProfileViewModel()
    
    var body: some View {
        VStack{
            PhotosPicker(selection:$vm.selectedPhoto,matching: .images){
                    
                    Image(systemName: "plus")
                         .font(.largeTitle)
                         .padding(28)
                         .background(
                              Circle()
                                   .fill(.thinMaterial)
                         )
                         .frame(width: 100)
                
                .padding(.horizontal,15)
                }
            
            .padding(10)
                    Text("John Smith")
                        .bold()
                .padding(20)
            
            HStack(spacing: 0) {
                ForEach(vm.tabs, id: \.self) { tab in
                    Button {
                        vm.selectTab(tab: tab)
                    } label: {
                        VStack {
                            Text(tab)
                                .foregroundStyle(.primary)
                            Rectangle()
                                .fill(vm.selectedTab == tab ? .cyan : .primary)
                                .frame(height: 2)
                                .padding(.top, 4)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            //.padding(20)
            
            
            //.padding(.leading,30)
            //        .navigationTitle(Text("Profile"))
            
            
            Spacer()
            
            
        }
    }
}

#Preview {
//    NavigationStack{
        ProfileView()
//    }
}
