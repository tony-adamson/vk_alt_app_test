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
    
    @State var friends = [Friend]()
    
    var body: some View {
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
        .padding(.top, 30)
        .onAppear {
            fvm.getFriends(token: lvm.token) { friends in
                self.friends = friends
                print(friends)
            }
        }
    }
}

#Preview {
    MainView()
}
