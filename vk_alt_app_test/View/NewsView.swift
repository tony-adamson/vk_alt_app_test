//
//  NewsView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 16.04.2024.
//

import SwiftUI

struct NewsView: View {
    
    @Bindable var lvm: LoginViewModel
    @StateObject var nvm = NewsViewModel()
    @State private var items = [Item]()
    @State private var profiles = [Profile]()
    @State private var groups = [Groups]()
    @State private var dates = [String]()
    @State private var likes = [Int]()
    @State private var photoURLs = [[String]]()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(items.indices, id: \.self) { index in
                        let newsItem = items[index]
                        let sourceId = newsItem.source_id
                        let date = dates[index]
                        let like = likes[index]
                        let photoURLs = photoURLs[index]
                        if sourceId < 0, let group = groups.first(where: { $0.id == abs(sourceId) }) {
                            NewsItemView(
                                text: newsItem.text,
                                photo: group.photo_50,
                                firstName: group.name,
                                secondName: "",
                                postDate: date,
                                likes: like,
                                photoURLs: photoURLs
                            )
                        } else if sourceId > 0, let profile = profiles.first(where: { $0.id == sourceId }) {
                            NewsItemView(
                                text: newsItem.text,
                                photo: profile.photo_50,
                                firstName: profile.first_name,
                                secondName: profile.last_name,
                                postDate: date,
                                likes: like,
                                photoURLs: photoURLs
                            )
                        }
                    }
                }
            }
            .onAppear {
                nvm.getNews(token: lvm.token) { items, profiles, groups, dates, likes, photoURLs in
                    self.items = items
                    self.profiles = profiles
                    self.groups = groups
                    self.dates = dates
                    self.likes = likes
                    self.photoURLs = photoURLs
                }
            }
        }
    }
}


#Preview {
    NewsView(lvm: LoginViewModel())
}
