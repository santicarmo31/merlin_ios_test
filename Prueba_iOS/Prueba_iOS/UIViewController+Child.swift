//
//  UIViewController+Child.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/22/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIViewController {
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
