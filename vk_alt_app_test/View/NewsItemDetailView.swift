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
    var newsItem: NewsItemModel
    
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
                            .onTapGesture {
                                if newsItem.userLikes == 0 {
                                    newsViewModel.addLike(
                                        token: loginViewModel.token,
                                        ownerId: newsItem.ownerId, itemId: newsItem.postId) { result in
                                            switch result {
                                            case .success(let newLikes):
                                                likes = newLikes
                                                newsItem.userLikes = 1
                                            case .failure(let error):
                                                print("Error adding like: \(error)")
                                            }
                                        }
                                } else {
                                    newsViewModel.removeLike(
                                        token: loginViewModel.token,
                                        ownerId: newsItem.ownerId, itemId: newsItem.postId) { result in
                                            switch result {
                                            case .success(let newLikes):
                                                likes = newLikes
                                                newsItem.userLikes = 0
                                            case .failure(let error):
                                                print("Error adding like: \(error)")
                                            }
                                        }
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

#Preview {
    NewsItemDetailView(
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
