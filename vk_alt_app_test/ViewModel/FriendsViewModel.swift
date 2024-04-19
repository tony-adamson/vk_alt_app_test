//
//  FriendsViewModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 14.04.2024.
//

import Foundation
import Alamofire

class FriendsViewModel: ObservableObject {
    func getFriends(token: String, completion: @escaping ([Friend]) -> ()) {
        let url = "https://api.vk.com/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "fields": "photo_50",
            "v": "5.199",
            "count": 30
        ]
        
        AF.request(url, method: .get, parameters: params).response { result in
            if let data = result.data {
                if let friends = try? JSONDecoder().decode(FriendsResponse.self, from: data).response.items {
                    completion(friends)
                }
            } 
        }
    }
}
