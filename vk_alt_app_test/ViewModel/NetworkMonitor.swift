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
    
    @Published var showAlert = false
    @Published var isConnected: Bool
    
    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitor")
        isConnected = false
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.isConnected = true
                    self?.showAlert = false
                } else {
                    self?.isConnected = false
                    self?.showAlert = true
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        DispatchQueue.main.async {
            self.isConnected = self.monitor.currentPath.status == .satisfied
            self.showAlert = !self.isConnected
        }
    }
}
