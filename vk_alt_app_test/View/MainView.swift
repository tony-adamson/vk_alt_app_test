//
//  MainView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

let gradientcolors: [Color] = [.gradientTop, .gradientBottom]

struct MainView: View {
    @EnvironmentObject var lvm: LoginViewModel
    
    @ObservedObject var fvm = FriendsViewModel()
    
    @ObservedObject var nvm = NewsViewModel()
    
    @State var friends = [Friend]()
    
    @State var items = [Item]()
    
    @State var profiles = [Profile]()
    
    @State var groups = [Groups]()
    
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            TabView {
                // Первая вкладка с друзьями
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(friends, id: \.self) { friend in
                            FriendItemView(firstName: friend.firstName, secondName: friend.lastName, photo: friend.photo)
                        }
                    }
                    .padding(10)
                }
                .tabItem {
                    Label("Friends", systemImage: "person.3.sequence.fill")
                }
                .onAppear {
                    fvm.getFriends(token: lvm.token) { friends in
                        self.friends = friends
                    }
                }
                
                // Вторая вкладка с новостями
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(items, id:\.id) { newsItem in
                            NewsItemView(text: newsItem.text)
                            
                        }
                    }
                }
                .tabItem {
                    Label("News", systemImage: "newspaper.fill")
                }
                .onAppear {
                    nvm.getNews(token: lvm.token) { response in
                        if let response = response {
                            self.items = response.items
                            self.profiles = response.profiles
                            self.groups = response.groups
                        }
                    }
                }
                
            }
            .background(Gradient(colors: gradientcolors))
            .foregroundStyle(.white)
        }
        .padding(.top, 30)
    }
}

//#Preview {
//    MainView()
//}
