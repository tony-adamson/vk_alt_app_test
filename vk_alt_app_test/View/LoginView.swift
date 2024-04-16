//
//  LoginView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct LoginView: View {
    @Bindable var loginViewModel = LoginViewModel()
    
    var body: some View {
        if loginViewModel.isLogin {
            MainView(lvm: loginViewModel)
        } else {
            WebView(token: $loginViewModel.token)
        }
    }
}

#Preview {
    LoginView()
}




