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
                    .font(.title3)
                    .padding(.bottom, 2)
                Text(secondName)
                    .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.green.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }
}

#Preview {
    FriendItemView(firstName: "hhh", secondName: "666", photo: "78878")
}
