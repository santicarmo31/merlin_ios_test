//
//  UIViewController+ActivityIndicator.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static let activityIndicator = UIActivityIndicatorView()
    
    func startActivityIndicator() {
        let activityIndicator = UIViewController.activityIndicator
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        UIViewController.activityIndicator.stopAnimating()
    }
}
