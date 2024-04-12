//
//  ContentView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = LoginViewModel()
    
    var body: some View {
        if !vm.authenticated {
            LoginView(vm: vm)
        } else {
            VStack {
                Text("Hello username")
                    .font(.largeTitle)
                Button("Log out") {
                    vm.logOut()
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ContentView()
}
