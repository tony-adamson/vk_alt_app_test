//
//  vk_alt_app_testApp.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

@main
struct vk_alt_app_testApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            if networkMonitor.isConnected {
                ContentView()
            } else {
                Text("No internet connection")
            }
        }
        .environmentObject(networkMonitor)
    }
}
