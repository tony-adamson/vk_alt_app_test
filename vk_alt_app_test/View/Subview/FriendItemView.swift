//
//  FriendItemView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 14.04.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct FriendItemView: View {
    var firstName: String
    var secondName: String
    var photo: String
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: photo))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(firstName)
                    .font(.system(size: 18, weight: .black))
                    .padding(.bottom, 2)
                Text(secondName)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.tint)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 10)
    }
}

#Preview {
    FriendItemView(firstName: "hhh", secondName: "666", photo: "78878")
}
