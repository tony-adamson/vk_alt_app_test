//
//  FriendsView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 16.04.2024.
//

import SwiftUI

struct FriendsView: View {
    
    @ObservedObject var lvm: LoginViewModel
    @State var friends = [Friend]()
    @ObservedObject var fvm = FriendsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(friends, id: \.self) { friend in
                        FriendItemView(firstName: friend.firstName, secondName: friend.lastName, photo: friend.photo)
                    }
                }
            }
            .navigationTitle("Friends")
            .onAppear {
                fvm.getFriends(token: lvm.token) { friends in
                    self.friends = friends
                }
            }
        }
        .alert(isPresented: $fvm.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(fvm.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    FriendsView(lvm: LoginViewModel())
}
