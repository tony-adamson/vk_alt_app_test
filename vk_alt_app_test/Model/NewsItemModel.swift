//
//  NewsItemModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 25.04.2024.
//

import Foundation

struct NewsItemModel: Identifiable {
    let id = UUID()
    var newsText: String
    var newsDate: String
    var likesCount: Int
    var repostsCount:Int
    var viewsCount: Int
    var authorName: String
    var authorPhotoURL: String
    var photoURLs: [String]
}
