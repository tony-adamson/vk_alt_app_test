//
//  NewsItemDetailView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 18.04.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct NewsItemDetailView: View {
    @ObservedObject var lvm: LoginViewModel
    @StateObject var nvm = NewsViewModel()
    var text: String
    @State var likes: Int
    var photoURLs: [String]
    @State var userLikes: Bool
    var canLike: Bool
    var ownerId: Int
    var postId: Int
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(text)
                    .padding()
                
                ForEach(photoURLs, id: \.self) { url in
                    WebImage(url: URL(string: url))
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
                
                if canLike {
                    HStack {
                        Image(systemName: userLikes ? "heart.fill" : "heart")
                            .onTapGesture {
                                if userLikes {
                                    nvm.removeLike(token: lvm.token, ownerId: ownerId, itemId: postId) { result in
                                        switch result {
                                        case .success(let newLikes):
                                            likes = newLikes
                                            userLikes = false
                                        case .failure(let error):
                                            print("Error removing like: \(error)")
                                        }
                                    }
                                } else {
                                    nvm.addLike(token: lvm.token, ownerId: ownerId, itemId: postId) { result in
                                        switch result {
                                        case .success(let newLikes):
                                            likes = newLikes
                                            userLikes = true
                                        case .failure(let error):
                                            print("Error adding like: \(error)")
                                        }
                                    }
                                }
                            }
                        Text("\(likes) likes")
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .navigationBarTitle("News Detail")
            .foregroundStyle(.white)
        }
        .background(.tint.opacity(0.6))
    }
}

#Preview {
    NewsItemDetailView(
        lvm: LoginViewModel(),
        text: "Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст ",
        likes: 5,
        photoURLs: [],
        userLikes: false,
        canLike: true,
        ownerId: 100,
        postId: 100
    )
}
