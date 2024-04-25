//
//  MainView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    // Первая вкладка с друзьями
                    FriendsView(lvm: loginViewModel)
                        .tabItem {
                            Image(systemName: "person.2")
                            Text("Friends")
                        }
                    
                    // Вторая вкладка с новостями
                    NewsView(loginViewModel: loginViewModel)
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text("News")
                        }
                }
            }
        }
    }
}

#Preview {
    MainView(loginViewModel: LoginViewModel())
}
