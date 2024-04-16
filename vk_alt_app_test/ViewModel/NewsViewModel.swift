//
//  NewsViewModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 15.04.2024.
//

import Foundation

import Foundation
import Alamofire

class NewsViewModel: ObservableObject {
    
    func getNews(token: String, completion: @escaping (Response?) -> ()) {
        let url = "https://api.vk.com/method/newsfeed.get"
        
        let params: Parameters = [
            "access_token": token,
            "filters": "post",
            "count": 10,
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data!)
                    completion(newsResponse.response)
                } catch {
                    print("Error decoding response: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
                completion(nil)
            }
        }
        
    }
    
}
