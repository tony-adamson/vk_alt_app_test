//
//  LoginViewModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import UIKit

class LoginViewModel: ObservableObject {
    
    @Published var isLogin = false
    
    @Published var token = "" {
        didSet {
            isLogin = true
        }
    }
}

//import Foundation
//import Observation
//import SwiftUI
//
//@Observable
//final class LoginViewModel {
//    var user = User()
//    var authenticated = false
//    
//    private var sampleUsername = "Username"
//    private var samplePassword = "Password"
//    
//    var isLoginButtonDisabled: Bool {
//        user.name.isEmpty || user.password.isEmpty
//    }
//    
//    func logIn() {
//        guard user.name == sampleUsername, user.password == samplePassword else { return }
//        
//        toggleAuthentication()
//    }
//    
//    func logOut() {
//        user.name = ""
//        user.password = ""
//        
//        toggleAuthentication()
//    }
//    
//    private func toggleAuthentication() {
//        withAnimation {
//            authenticated.toggle()
//        }
//    }
//    
//}
