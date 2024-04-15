//
//  PostView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct PostItemView: View {
    @Binding var mainText: String?
    @Binding var postImage: Image?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Аватарка и имя пользователя")
                .padding([.top, .leading, .trailing], 16)
            
            if mainText != nil {
                Text(mainText!)
                    .padding([.top, .leading, .trailing], 16)
            }
            
            if postImage != nil {
                postImage!
                    .resizable()
                    .scaledToFit()
            }
            
            
            Text("Строка с индикаторами и значками")
                .padding([.bottom, .leading, .trailing], 16)
        }
        .background(.green)
    }
}

#Preview {
    PostItemView(mainText: .constant("simple text"), postImage: .constant(Image("sample")))
}
