//
//  UIViewController+NetworkReachable.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIViewController {
    
    // Method to override in case we need to handle network status
    func networkNotReachable() {}
    
    // Method to override in case we need to handle network status
    func networkReachable() {}
    
    func observeNetworkStatus() {
        let manager: AFNetworkReachabilityManager = AFNetworkReachabilityManager.shared()
        manager.setReachabilityStatusChange { (status) in
            
            if status == AFNetworkReachabilityStatus.notReachable {
                self.networkNotReachable()
            } else {
                self.networkReachable()
            }
        }
        manager.startMonitoring()
    }
}
