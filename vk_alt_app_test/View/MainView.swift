//
//  MainView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

let gradientcolors: [Color] = [.gradientTop, .gradientBottom]

struct MainView: View {
    @Bindable var lvm: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    // Первая вкладка с друзьями
                    FriendsView(lvm: lvm)
                        .tabItem {
                            Image(systemName: "person.2")
                            Text("Friends")
                        }
                        .background(Gradient(colors: gradientcolors))
                    
                    // Вторая вкладка с новостями
                    NewsView(lvm: lvm)
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text("News")
                        }
                        .background(Gradient(colors: gradientcolors))
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    MainView(lvm: LoginViewModel())
}
