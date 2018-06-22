//
//  UIViewController+ActivityIndicator.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/22/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIViewController {
    static var spinners: [String: LoadingViewController] = [:]
    
    var spinnerKey: String {
        return String(describing: self)
    }
    
    func showSpinner() {
        var controller: LoadingViewController?
        defer {
            if let controller = controller {
                add(controller)
            }
        }
        
        if let existingController = UIViewController.spinners[spinnerKey] {
            controller = existingController
        } else {            
            controller = LoadingViewController()
            UIViewController.spinners[spinnerKey] = controller
        }
    }
    
    func hideSpinner() {
        if let controller = UIViewController.spinners[spinnerKey] {
            controller.remove()
        }
    }
}
