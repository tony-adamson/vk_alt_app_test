//
//  LoginViewModel.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import Foundation
import Observation
import SwiftUI

@Observable
class LoginViewModel {
    
    var isLogin = false
    
    var token = "" {
        didSet {
            isLogin = true
        }
    }
}
