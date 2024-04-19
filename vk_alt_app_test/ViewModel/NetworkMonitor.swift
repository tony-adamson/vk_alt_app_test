//
//  NetworkMonitor.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 19.04.2024.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    @Published var isConnected: Bool
    
    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitor")
        isConnected = false
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
