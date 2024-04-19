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
    var source_id: Int
    var date: Int
    var attachments: [Attachment]
    var id: Int
    var is_favorite: Bool
    var likes: Like
    var text: String
    var views: Views
    var post_id: Int
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
    var photo: Photo?
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

struct Photo: Decodable {
    var album_id: Int
    var date: Int
    var id: Int
    var owner_id: Int
    var access_key: String
    var sizes: [Sizes]
}

struct Sizes: Decodable {
    var height: Int
    var type: String
    var width: Int
    var url: String
    var text: String?
    var user_id: Int?
    var web_view_token: String?
    var has_tags: Bool?
}

struct LikeResponse: Decodable {
    var response: LikeR
}

struct LikeR: Decodable {
    var likes: Int
}
