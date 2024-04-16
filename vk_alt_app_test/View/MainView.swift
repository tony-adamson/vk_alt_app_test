//
//  MainView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var lvm: LoginViewModel
    
    @ObservedObject var fvm = FriendsViewModel()
    
    @ObservedObject var nvm = NewsViewModel()
    
    @State var friends = [Friend]()
    
    @State var news = [Item]()
    
    @State private var selectedTab = 0
    
    var body: some View {
            VStack {
                TabView(selection: $selectedTab) {
                    // Первая вкладка с друзьями
                    ZStack {
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(friends, id: \.self) { friend in
                                    FriendItemView(firstName: friend.firstName, secondName: friend.lastName, photo: friend.photo)
                                }
                            }
                            .padding(10)
                        }
                    }
                    .tag(0)
                    .onAppear {
                        fvm.getFriends(token: lvm.token) { friends in
                            self.friends = friends
                        }
                    }
                    
                    // Вторая вкладка с новостями
                    ZStack {
                        //Text("123")
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(news, id:\.id) { newsItem in
                                    NewsItemView(text: newsItem.text)
                                    
                                }
                            }
                        }
                    }
                    .tag(1)
                    .onAppear {
                        nvm.getNews(token: lvm.token) { news in
                            self.news = news
                        }
                    }
                }
                
                // Нижний бар с вкладками
                TabBar(selectedTab: $selectedTab)
            }
            .padding(.top, 30)
        }
    }

//#Preview {
//    MainView()
//}
