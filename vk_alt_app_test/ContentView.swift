//
//  ContentView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var lvm = LoginViewModel()
//    @State private var vm = LoginViewModel()
    
    var body: some View {
        //        if !vm.authenticated {
        //            LoginView(vm: vm)
        LoginView()
            .ignoresSafeArea(.all)
//        } else {
//            MainView()
//        }
    }
}

#Preview {
    ContentView()
}
