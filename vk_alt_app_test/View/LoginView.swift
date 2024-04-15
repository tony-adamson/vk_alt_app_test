//
//  LoginView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct LoginView: View {
//    @Bindable var vm: LoginViewModel
    @ObservedObject var lvm = LoginViewModel()
//    @State var token = ""
    
    var body: some View {
        if lvm.isLogin {
            MainView()
                .environmentObject(lvm)
        } else {
            WebView(token: $lvm.token)
        }

//        ZStack {
//            Color.blue.opacity(0.07)
//                .ignoresSafeArea()
//            
//            VStack {
//                Text("Welcome!")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding(.top, 100)
//                
//                VStack(spacing: 15) {
//                    TextField("Username", text: $vm.user.name)
//                        .customStyle()
//                    SecureField("Password", text: $vm.user.password)
//                        .customStyle()
//                }
//                .padding()
//                
//                
//                ButtonView(isDisabled: vm.isLoginButtonDisabled) {
//                    vm.logIn()
//                }
//                
//                Spacer()
//            }
//        }
    }
}

#Preview {
//    LoginView(vm: LoginViewModel())
    LoginView()
}




