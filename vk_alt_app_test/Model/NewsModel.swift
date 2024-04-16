//
//  News.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 15.04.2024.
//

import Foundation

struct NewsResponse: Decodable {
    var response: Response
}

struct Response: Decodable {
    var items: [Item]
    var profiles: [Profile]
    var groups: [Groups]
}

struct Item: Decodable {
    var type: String
    var date: Date
    var attachments: [Attachment]
    var id: Int
    var is_favorite: Bool
    var likes: Like
    var text: String
    var views: Views
}

struct Like: Decodable, Hashable {
    var can_like: Int
    var count: Int
    var user_likes: Int
    var can_publish: Int
    var repost_disabled: Bool
}

struct Attachment: Decodable {
    var type: String
    //let photo: [Photo]
}

struct Views: Decodable {
    var count: Int
}

struct Profile: Decodable, Hashable {
    var id: Int
    var photo_50: String
    var first_name: String
    var last_name: String
}

struct Groups: Decodable, Hashable {
    var id: Int
    var name: String
    var photo_50: String
}
