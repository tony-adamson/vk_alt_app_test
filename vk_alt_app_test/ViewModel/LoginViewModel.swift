//
//  LoginViewModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var isLogin = false
    
    @Published var token = "" {
        didSet {
            isLogin = true
        }
    }
}
