//
//  DetailTableViewController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlest
    
    @IBOutlet var appImage: UIImageView!
    @IBOutlet var appTitle: UILabel!
    @IBOutlet var appDescription: UILabel!
    
    // MARK: - Vars & Constants
    
    var app: App?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerBar()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
    }
    
    override func navigationShouldPopOnBackButton() -> Bool {
        
        if ((self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone && self.traitCollection.displayScale == 3.0))
        {
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = nil;
        }
        
        return true;
    }
    
    // MARK: - IBActions

    @IBAction func dismissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func setupView() {
        self.appTitle.text = self.app?.title;
        self.appDescription.text = self.app?.summitText;
        self.setupImage()
    }
    
    private func setupImage() {
        let rawImageURL: String? = self.app?.bannerImg ?? self.app?.iconImg
        let placeHolderImage = UIImage(named: "no_image_black")
        
        if let imageURL = rawImageURL, let url = URL(string: imageURL) {
            appImage.setImageWith(url, placeholderImage: placeHolderImage)
        } else {
            appImage.image = placeHolderImage
        }
    }
    
    private func setupNavigationControllerBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "shadow"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage();
        
        if self.parent?.childViewControllers.first != self
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
}

// MARK: - Table view data source

extension DetailTableViewController {
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension;
    }
}
