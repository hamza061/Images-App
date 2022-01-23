//
//  NetworkServices.swift
//  Astute Assignment
//
//  Created by Yasin on 23/01/2022.
//

import Foundation
import Network

final class NetworkServices {
    public static let shared = NetworkServices()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public var connectionType: ConecctionType = .unknown
    enum ConecctionType {
        case wifi
        case celluler
        case ethernet
        case unknown
    }
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .celluler
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
}
