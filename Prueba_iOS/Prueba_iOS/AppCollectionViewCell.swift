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
    
    // MARK: - Vars & Constants
    var rawImageURL: String?
    
    // MARK: - Methods
    
    func setCellDataFrom(app: App) {
        appTitle.text = app.title
        appDescription.text = app.summitText        
        
        rawImageURL = app.iconImg ?? app.bannerImg
        appImage.setImage(fromUrl: rawImageURL, placeHolderImageName: "no_image_black")
        
    }
}
