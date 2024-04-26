//
//  NewsView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 16.04.2024.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(newsViewModel.newsItems) { newsItem in
                        NewsItemView(loginViewModel: loginViewModel, newsItem: newsItem)
                    }
                }
            }
            .navigationTitle("News Feed")
            .onAppear {
                newsViewModel.getNews(token: loginViewModel.token)
            }
        }
    }
}

#Preview {
    NewsView(loginViewModel: LoginViewModel())
}
