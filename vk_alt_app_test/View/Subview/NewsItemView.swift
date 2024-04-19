//
//  PostView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct NewsItemView: View {
    var text: String
    var photo: String
    var firstName: String
    var secondName: String
    var postDate: String
    var likes: Int
    var photoURLs: [String]
    
    var body: some View {
        NavigationLink(destination: NewsItemDetailView(
            text: text,
            likes: likes,
            photoURLs: photoURLs)
        ) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    WebImage(url: URL(string: photo))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.vertical, 16)
                        .padding(.leading, 16)
                    VStack(alignment: .leading) {
                        Text(firstName)
                            .font(.system(size: 18, weight: .black))
                        if secondName != "" {
                            Text(secondName)
                        }
                    }
                }
                
                Text(text)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom, .leading, .trailing], 16)
                
                Text("Дата публикации - \(postDate)")
                    .font(.caption)
                    .padding([.bottom, .leading], 16)
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(.tint)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    NewsItemView(
        text: "kjdfjnkdfnvjndfkvjkdfnkvnkdfjnvkdfnkvnkdfnvkdfjnvkdfnkvnkdfnvkdfnkvndjfkvnkdfjnkvndfkjnvkdfjnkvdfjvk",
        photo: "12121",
        firstName: "Ivan",
        secondName: "Ivanov",
        postDate: "121331",
        likes: 5,
        photoURLs: []
    )
}
