//
//  Model.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 14.04.2024.
//

import Foundation

struct FriendsResponse: Decodable {
    var response: Friends
}

struct Friends: Decodable {
    var items: [Friend]
}

struct Friend: Decodable, Hashable {
    var photo: String
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
}
