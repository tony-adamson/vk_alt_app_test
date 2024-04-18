//
//  LoginView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct LoginView: View {
    @Bindable var loginViewModel = LoginViewModel()
    @State private var showMainView = false
    
    var body: some View {
        if loginViewModel.isLogin {
            withAnimation(.easeInOut(duration: 0.8)) {
                MainView(lvm: loginViewModel)
                    .opacity(showMainView ? 1 : 0)
                    .onAppear {
                        showMainView = true
                    }
            }
        } else {
            WebView(token: $loginViewModel.token)
        }
    }
}

#Preview {
    LoginView()
}




