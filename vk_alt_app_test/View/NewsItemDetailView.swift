//
//  NewsItemDetailView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 18.04.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct NewsItemDetailView: View {
    var text: String
    var likes: Int
    var photoURLs: [String]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(text)
                    .padding()
                
                ForEach(photoURLs, id: \.self) { url in
                    WebImage(url: URL(string: url))
                }
                
                HStack {
                    Image(systemName: "heart")
                    Text("\(likes) likes")
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .navigationBarTitle("News Detail")
            .foregroundStyle(.white)
        }
        .background(.tint.opacity(0.6))
    }
}

#Preview {
    NewsItemDetailView(
        text: "Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст Это очень очень длинный текст ",
        likes: 5,
        photoURLs: []
    )
}
