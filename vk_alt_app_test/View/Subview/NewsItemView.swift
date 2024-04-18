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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Аватарка и имя пользователя")
                .padding([.top, .leading, .trailing], 16)
            
            HStack {
                WebImage(url: URL(string: photo))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                .padding(.vertical, 16)
            }
            
            Text(text)
                .padding([.bottom, .leading, .trailing], 16)
        }
        .frame(maxWidth: .infinity)
        .background(.tint)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }
}

#Preview {
    NewsItemView(text: "kjdfjnkdfnvjndfkvjkdfnkvnkdfjnvkdfnkvnkdfnvkdfjnvkdfnkvnkdfnvkdfnkvndjfkvnkdfjnkvndfkjnvkdfjnkvdfjvk",
    photo: "12121",
    firstName: "Ivan",
    secondName: "Ivanov")
}
