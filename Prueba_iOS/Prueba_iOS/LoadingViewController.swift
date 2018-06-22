//
//  LoadingViewController.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/22/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }        
}

