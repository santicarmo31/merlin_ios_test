//
//  EmptyMessageViewController.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/22/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import UIKit

class EmptyMessageViewController: UIViewController {
    
    // MARK: - Vars & Constants

    var message: String? = "Prueba_iOS" {
        didSet {
            messageLabel.text = message
        }
    }
    private lazy var messageLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMessageLabelConstraints()
        setupMessageLabel()
        messageLabel.text = message
    }       
    
    // MARK: - Methods
    
    private func setMessageLabelConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate(
            [
                messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    private func setupMessageLabel() {
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.numberOfLines = 3
        messageLabel.textAlignment = .center
    }

}
