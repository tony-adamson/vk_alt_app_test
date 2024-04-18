//
//  NewsView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 16.04.2024.
//

import SwiftUI

struct NewsView: View {
    
    @Bindable var lvm: LoginViewModel
    @ObservedObject var nvm = NewsViewModel()
    @State var items = [Item]()
    @State var profiles = [Profile]()
    @State var groups = [Groups]()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(items, id:\.id) { newsItem in
                        let sourceId = newsItem.source_id
                        if sourceId < 0, let group = groups.first(where: { $0.id == abs(sourceId) }) {
                            NewsItemView(text: newsItem.text, photo: group.photo_50, firstName: group.name, secondName: "")
                        } else if sourceId > 0, let profile = profiles.first(where: { $0.id == sourceId }) {
                            NewsItemView(text: newsItem.text, photo: profile.photo_50, firstName: profile.first_name, secondName: profile.last_name)
                        }
                    }
                }
            }
            .onAppear {
                nvm.getNews(token: lvm.token) { items, profiles, groups in
                    self.items = items
                    self.profiles = profiles
                    self.groups = groups
                }
            }
        }
    }
}

//#Preview {
//    NewsView()
//}
