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
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItemModel] = []
    var cancellables = Set<AnyCancellable>()

    // Get news feed
    func getNews(token: String) {
        let url = "https://api.vk.com/method/newsfeed.get"
        let parameters: [String: Any] = [
            "access_token": token,
            "filters": "post",
            "count": 20,
            "v": "5.199"
        ]

        AF.request(url, method: .get, parameters: parameters)
            .publishDecodable(type: NewsResponse.self)
            .compactMap { $0.value }
            .map { $0.response }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.processNewsData(response: response)
            })
            .store(in: &cancellables)
    }

    // Преобразование полученных данных в агрегированную модель
    private func processNewsData(response: Response) {
        let items = response.items
        let profiles = response.profiles
        let groups = response.groups

        newsItems = items.map { item in
            let date = self.formatDate(item.date)
            let photoURLs = self.getBestSizePhotoURLs(from: item)
            let likesCount = item.likes.count
            let repostsCount = item.reposts.count
            let viewsCount = item.views.count

            if item.source_id > 0, let profile = profiles.first(where: { $0.id == item.source_id }) {
                return NewsItemModel(
                    newsText: item.text,
                    newsDate: date,
                    likesCount: likesCount,
                    repostsCount: repostsCount,
                    viewsCount: viewsCount,
                    authorName: "\(profile.first_name) \(profile.last_name)",
                    authorPhotoURL: profile.photo_50,
                    photoURLs: photoURLs
                )
            } else if item.source_id < 0, let group = groups.first(where: { $0.id == abs(item.source_id) }) {
                return NewsItemModel(
                    newsText: item.text,
                    newsDate: date,
                    likesCount: likesCount,
                    repostsCount: repostsCount,
                    viewsCount: viewsCount,
                    authorName: group.name,
                    authorPhotoURL: group.photo_50,
                    photoURLs: photoURLs
                )
            } else {
                return NewsItemModel(
                    newsText: item.text,
                    newsDate: date,
                    likesCount: likesCount,
                    repostsCount: repostsCount,
                    viewsCount: viewsCount,
                    authorName: "Unknown",
                    authorPhotoURL: "",
                    photoURLs: photoURLs
                )
            }
        }
    }


    private func formatDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: date)
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
}
