//
//  ContentView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        Group {
            if networkMonitor.isConnected {
                LoginView()
                    .ignoresSafeArea(.all)
            } else {
                Text("Checking network...")
            }
        }
        .alert(isPresented: $networkMonitor.showAlert) {
            Alert(
                title: Text("No Internet Connection"),
                message: Text("Please check your internet connection and try again."),
                dismissButton: .default(Text("Try Again")) {
                    networkMonitor.startMonitoring()
                }
            )
        }
    }
}

#Preview {
    ContentView()
}



