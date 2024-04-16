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
                        NewsItemView(text: newsItem.text)
                        
                    }
                }
            }
            .onAppear {
                nvm.getNews(token: lvm.token) { response in
                    if let response = response {
                        self.items = response.items
                        self.profiles = response.profiles
                        self.groups = response.groups
                    }
                }
            }
        }
    }
}

//#Preview {
//    NewsView()
//}
