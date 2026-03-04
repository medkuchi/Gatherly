//
//  ProfileView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/4/26.
//

import SwiftUI

struct ProfileView: View {
    @Bindable var vm = ProfileViewModel()
    var body: some View {
        VStack{
            
            HStack{
                Button{
                    
                }
                label:{
                    ZStack{
                        Ellipse()
                        //.stroke(Color.gray, lineWidth:1)
                            .frame(width:150,height:150)
                            .foregroundStyle(.regularMaterial)
                        
                        
                        Image(systemName:"plus")
                            .font(.largeTitle)
                    }
                    .padding(.horizontal,15)
                }
            }
            .padding(10)
                HStack{
                    Text("John Smith")
                        .bold()
                }
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
            
            
            .padding(80)
            Spacer()
            
            
        }
    }
}

#Preview {
//    NavigationStack{
        ProfileView()
//    }
}
