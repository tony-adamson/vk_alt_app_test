//
//  MainView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

let gradientcolors: [Color] = [.gradientTop, .gradientBottom]

struct MainView: View {
    @Bindable var lvm: LoginViewModel
    
    var body: some View {
        VStack {
            TabView {
                // Первая вкладка с друзьями
                FriendsView(lvm: lvm)
                
                // Вторая вкладка с новостями
                NewsView(lvm: lvm)
            }
            .background(Gradient(colors: gradientcolors))
            .tabViewStyle(.page)
            .foregroundStyle(.white)
        }
        .padding(.top, 30)
    }
}

//#Preview {
//    MainView()
//}
