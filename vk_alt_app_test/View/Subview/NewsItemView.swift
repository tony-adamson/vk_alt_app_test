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
    @ObservedObject var lvm: LoginViewModel
    @StateObject var nvm = NewsViewModel()
    var text: String
    var photo: String
    var firstName: String
    var secondName: String
    var postDate: String
    var likes: Int
    var photoURLs: [String]
    var userLikes: Bool
    var canLike: Bool
    var ownerId: Int
    var postId: Int
    
    var body: some View {
        NavigationLink(destination: NewsItemDetailView(
            lvm: lvm,
            text: text,
            likes: likes,
            photoURLs: photoURLs,
            userLikes: userLikes,
            canLike: canLike,
            ownerId: ownerId,
            postId: postId)
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
        lvm: LoginViewModel(),
        text: "kjdfjnkdfnvjndfkvjkdfnkvnkdfjnvkdfnkvnkdfnvkdfjnvkdfnkvnkdfnvkdfnkvndjfkvnkdfjnkvndfkjnvkdfjnkvdfjvk",
        photo: "12121",
        firstName: "Ivan",
        secondName: "Ivanov",
        postDate: "121331",
        likes: 5,
        photoURLs: [],
        userLikes: false,
        canLike: true,
        ownerId: 100,
        postId: 100
    )
}
