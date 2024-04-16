//
//  TabBar.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 15.04.2024.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                VStack {
                    Image(systemName: "person.3.sequence.fill")
                    Text("Друзья")
                }
                .padding()
            }
            .background(selectedTab == 0 ? Color.blue : Color.clear)
            .foregroundColor(selectedTab == 0 ? .white : .blue)
            
            Spacer()
            
            Button(action: {
                selectedTab = 1
            }) {
                VStack {
                    Image(systemName: "newspaper.fill")
                    Text("Новости")
                }
                .padding()
            }
            .background(selectedTab == 1 ? Color.blue : Color.clear)
            .foregroundColor(selectedTab == 1 ? .white : .blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    TabBar(selectedTab: .constant(1))
}
