//
//  ContentView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var lvm = LoginViewModel()
    
    var body: some View {
        LoginView()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
