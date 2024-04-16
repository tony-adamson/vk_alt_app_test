//
//  PostView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct NewsItemView: View {
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Аватарка и имя пользователя")
                .padding([.top, .leading, .trailing], 16)
            
            Text(text)
                .padding([.bottom, .leading, .trailing], 16)
        }
        .frame(maxWidth: .infinity)
        .background(.green)
    }
}

#Preview {
    NewsItemView(text: "123")
}
