//
//  UIViewController+BaseView.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIViewController: BaseView {
    
    func startSpinner() {
        showSpinner()
    }
    
    func stopSpinner() {
        hideSpinner()
    }
}
