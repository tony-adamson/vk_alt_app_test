//
//  FriendsView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 16.04.2024.
//

import SwiftUI

struct FriendsView: View {
    
    @Bindable var lvm: LoginViewModel
    @State var friends = [Friend]()
    @ObservedObject var fvm = FriendsViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(friends, id: \.self) { friend in
                        FriendItemView(firstName: friend.firstName, secondName: friend.lastName, photo: friend.photo)
                    }
                }
                .padding(10)
            }
            .onAppear {
                fvm.getFriends(token: lvm.token) { friends in
                    self.friends = friends
                }
            }
        }
    }
}

//#Preview {
//    FriendsView()
//}
