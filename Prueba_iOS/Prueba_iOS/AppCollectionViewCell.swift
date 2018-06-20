//
//  AppCollectionViewCell.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var appImage: UIImageView!
    @IBOutlet var appTitle: UILabel!
    @IBOutlet var appDescription: UILabel!
    
    // MARK: - Methods
    
    func setCellDataFrom(app: App) {
        appTitle.text = app.title
        appDescription.text = app.summitText        
        
        let rawImageURL: String? = app.iconImg ?? app.bannerImg
        let placeHolderImage = UIImage(named: "no_image_black")
        
        if let imageURL = rawImageURL, let url = URL(string: imageURL) {
            appImage.setImageWith(url, placeholderImage: placeHolderImage)
        } else {
            appImage.image = placeHolderImage
        }
        
    }
}
