//
//  NewsItemModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 25.04.2024.
//

import Foundation

class NewsItemModel: Identifiable, ObservableObject {
    let id = UUID()
    var newsText: String
    var newsDate: String
    @Published var likesCount: Int
    var repostsCount:Int
    var viewsCount: Int
    var authorName: String
    var authorPhotoURL: String
    var photoURLs: [String]
    var canLike: Int
    @Published var userLikes: Int
    var ownerId : Int
    var postId: Int
    
    init(newsText: String, newsDate: String, likesCount: Int, repostsCount: Int, viewsCount: Int, authorName: String, authorPhotoURL: String, photoURLs: [String], canLike: Int, userLikes: Int, ownerId: Int, postId: Int) {
            self.newsText = newsText
            self.newsDate = newsDate
            self.likesCount = likesCount
            self.repostsCount = repostsCount
            self.viewsCount = viewsCount
            self.authorName = authorName
            self.authorPhotoURL = authorPhotoURL
            self.photoURLs = photoURLs
            self.canLike = canLike
            self.userLikes = userLikes
            self.ownerId = ownerId
            self.postId = postId
        }
}
