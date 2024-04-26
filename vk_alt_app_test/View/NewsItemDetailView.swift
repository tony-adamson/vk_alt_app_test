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
    @ObservedObject var loginViewModel: LoginViewModel
    @StateObject var newsViewModel = NewsViewModel()
    @ObservedObject var newsItem: NewsItemModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                // up info block
                HStack {
                    WebImage(url: URL(string: newsItem.authorPhotoURL))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(newsItem.authorName)
                            .font(.title3)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Text(newsItem.newsDate)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                
                // Block with news
                Text(newsItem.newsText)
                    .multilineTextAlignment(.leading)
                
                // Block with photo
                if !newsItem.photoURLs.isEmpty {
                    ForEach(newsItem.photoURLs, id: \.self) { url in
                        WebImage(url: URL(string: url))
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    }
                }
                
                
                //Block with additional info
                HStack {
                    if newsItem.canLike == 1 {
                        Image(systemName: newsItem.userLikes == 0 ? "heart" : "heart.fill")
                            .foregroundColor(newsItem.userLikes == 0 ? .gray : .red)
                            .onTapGesture {
                                if newsItem.userLikes == 0 {
                                    newsItem.userLikes = 1
                                    newsItem.likesCount += 1
                                } else {
                                    newsItem.userLikes = 0
                                    newsItem.likesCount -= 1
                                }
                            }
                        Text("\(newsItem.likesCount)")
                    }
                    Image(systemName: "repeat")
                        .padding(.leading, 8)
                    Text("\(newsItem.repostsCount)")
                    Spacer()
                    Text("\(newsItem.viewsCount)")
                    Image(systemName: "eye")
                }
                .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.green.opacity(0.1))
            .foregroundStyle(.black)
        }
        .scrollIndicators(.hidden)
        .padding()
    }
}


//struct NewsItemDetailView: View {
//    @ObservedObject var loginViewModel: LoginViewModel
//    @StateObject var newsViewModel = NewsViewModel()
//    var text: String
//    @State var likes: Int
//    var photoURLs: [String]
//    @State var userLikes: Int
//    var canLike: Int
//    var ownerId: Int
//    var postId: Int
    
//    var body: some View {
//        ScrollView(.vertical) {
//            VStack(alignment: .leading) {
//                Text(text)
//                    .padding()
//                
//                ForEach(photoURLs, id: \.self) { url in
//                    WebImage(url: URL(string: url))
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity)
//                }
//                
//                if canLike == 1 {
//                    HStack {
//                        Image(systemName: userLikes == 1 ? "heart.fill" : "heart")
//                            .foregroundColor(userLikes == 0 ? .gray : .red)
//                            .onTapGesture {
//                                if userLikes == 1 {
//                                    newsViewModel.removeLike(token: loginViewModel.token, ownerId: ownerId, itemId: postId) { result in
//                                        switch result {
//                                        case .success(let newLikes):
//                                            likes = newLikes
//                                            userLikes = 0
//                                        case .failure(let error):
//                                            print("Error removing like: \(error)")
//                                        }
//                                    }
//                                } else {
//                                    newsViewModel.addLike(token: loginViewModel.token, ownerId: ownerId, itemId: postId) { result in
//                                        switch result {
//                                        case .success(let newLikes):
//                                            likes = newLikes
//                                            userLikes = 1
//                                        case .failure(let error):
//                                            print("Error adding like: \(error)")
//                                        }
//                                    }
//                                }
//                            }
//                        Text("\(likes) likes")
//                    }
//                    .padding()
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .navigationBarTitle("News Detail")
//            .foregroundStyle(.white)
//        }
//        .background(.tint.opacity(0.6))
//    }
//}

#Preview {
    NewsItemDetailView(
//        loginViewModel: LoginViewModel(), text: "qwerty", likes: 10, photoURLs: [], userLikes: 0, canLike: 1, ownerId: 100, postId: 200
        loginViewModel: LoginViewModel(),
        newsItem: NewsItemModel(
            newsText: "qwerty",
            newsDate: "123-122-122",
            likesCount: 10,
            repostsCount: 10,
            viewsCount: 10,
            authorName: "Vasya Pupkins",
            authorPhotoURL: "",
            photoURLs: [],
            canLike: 1,
            userLikes: 0,
            ownerId: 100,
            postId: 200
        )
    )
}
