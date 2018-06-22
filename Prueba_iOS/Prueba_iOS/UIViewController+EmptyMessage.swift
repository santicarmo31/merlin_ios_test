//
//  UIViewController+EmptyMessage.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/22/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIViewController {
    static var emptyMessages: [String: EmptyMessageViewController] = [:]
    
    var emptyMessageKey: String {
        return String(describing: self)
    }
    
    func showEmptyMessage(_ message: String) {
        var controller: EmptyMessageViewController?
        defer {
            if let controller = controller {
                controller.message = message
                add(controller)
            }
        }
        
        if let existingController = UIViewController.emptyMessages[emptyMessageKey] {
            controller = existingController
        } else {
            controller = EmptyMessageViewController()
            UIViewController.emptyMessages[emptyMessageKey] = controller
        }        
    }
    
    func hideEmptyMessage() {
        if let controller = UIViewController.emptyMessages[emptyMessageKey] {
            controller.remove()
        }
    }
}
