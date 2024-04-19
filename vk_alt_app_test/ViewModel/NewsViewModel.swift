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
    
    func getNews(token: String, completion: @escaping ([Item], [Profile], [Groups], [String], [Int], [[String]]) -> ()) {
        let url = "https://api.vk.com/method/newsfeed.get"
        
        let params: Parameters = [
            "access_token": token,
            "filters": "post",
            "count": 20,
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data!)
                    let items = newsResponse.response.items
                    let dates = items.map { self.formatDate($0.date) }
                    let profiles = newsResponse.response.profiles
                    let groups = newsResponse.response.groups
                    let likes = items.map { $0.likes.count }
                    let photoURLs = items.map { self.getSmallSizePhotoURLs(from: $0) }
                    completion(items, profiles, groups, dates, likes, photoURLs)
                } catch {
                    print("Error decoding response: \(error)")
                    completion([], [], [], [], [], [])
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
                completion([], [], [], [], [], [])
            }
        }
    }
    
    private func formatDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    private func getSmallSizePhotoURLs(from item: Item) -> [String] {
        var urls: [String] = []
        
        for attachment in item.attachments {
            if let photo = attachment.photo {
                for size in photo.sizes {
                    if size.type == "s" {
                        urls.append(size.url)
                    }
                }
            }
        }
        
        return urls
    }
}
