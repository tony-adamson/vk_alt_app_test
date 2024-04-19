//
//  NewsViewModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 15.04.2024.
//

import Foundation

import Foundation
import Alamofire
import UIKit

class NewsViewModel: ObservableObject {
    
    // Get news feed
    func getNews(token: String, completion: @escaping ([Item], [Profile], [Groups], [String], [Int], [[String]], [Bool], [Bool], [Int], [Int]) -> ()) {
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
                    let photoURLs = items.map { self.getBestSizePhotoURLs(from: $0) }
                    let userLikes = items.map { $0.likes.user_likes == 1 }
                    let canLike = items.map { $0.likes.can_like == 1 }
                    let ownerId = items.map { $0.source_id }
                    let post_id = items.map { $0.post_id }
                    completion(items, profiles, groups, dates, likes, photoURLs, userLikes, canLike, ownerId, post_id)
                } catch {
                    print("Error decoding response: \(error)")
                    completion([], [], [], [], [], [], [], [], [], [])
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
                completion([], [], [], [], [], [], [], [], [], [])
            }
        }
    }
    
    // Add Like function
    func addLike(token: String, ownerId: Int, itemId: Int, completion: @escaping (Result<Int, Error>) -> ()) {
        let url = "https://api.vk.com/method/likes.add"
        
        let params: Parameters = [
            "access_token": token,
            "type": "post",
            "owner_id": ownerId,
            "item_id": itemId,
            "v": "5.199"
        ]
       
        AF.request(url, method: .get, parameters: params).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let likeResponse = try JSONDecoder().decode(LikeResponse.self, from: data!)
                    completion(.success(likeResponse.response.likes))
                } catch {
                    print("Error decoding response: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error adding like: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // Dislike function
    func removeLike(token: String, ownerId: Int, itemId: Int, completion: @escaping (Result<Int, Error>) -> ()) {
        let url = "https://api.vk.com/method/likes.delete"
        
        let params: Parameters = [
            "access_token": token,
            "type": "post",
            "owner_id": ownerId,
            "item_id": itemId,
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let likeResponse = try JSONDecoder().decode(LikeResponse.self, from: data!)
                    completion(.success(likeResponse.response.likes))
                } catch {
                    print("Error decoding response: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error removing like: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func formatDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    private func getBestSizePhotoURLs(from item: Item) -> [String] {
        var urls: [String] = []
        
        let screenWidth = UIScreen.main.bounds.width

        for attachment in item.attachments {
            if let photo = attachment.photo {
                let bestSize = getBestSize(for: photo.sizes, screenWidth: screenWidth)
                urls.append(bestSize.url)
            }
        }
        
        return urls
    }
    
    private func getBestSize(for sizes: [Sizes], screenWidth: CGFloat) -> Sizes {
        let sortedSizes = sizes.sorted { $0.width > $1.width }
        
        for size in sortedSizes {
            if CGFloat(size.width) >= screenWidth {
                return size
            }
        }
        
        return sortedSizes.first!
    }
    
    // TODO: Unused function
//    private func getSmallSizePhotoURLs(from item: Item) -> [String] {
//        var urls: [String] = []
//
//        for attachment in item.attachments {
//            if let photo = attachment.photo {
//                for size in photo.sizes {
//                    if size.type == "q" {
//                        urls.append(size.url)
//                    }
//                }
//            }
//        }
//        return urls
//    }
}
