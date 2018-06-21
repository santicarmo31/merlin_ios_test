//
//  AppTableViewCell.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var appImage: UIImageView!
    @IBOutlet var appTitle: UILabel!
    @IBOutlet var appDescription: UILabel!
    
    var rawImageURL: String? = nil
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func setCellDataFrom(app: App) {
        appTitle.text = app.title
        appDescription.text = app.summitText
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    
        rawImageURL = app.iconImg ?? app.bannerImg
        appImage.setImage(fromUrl: rawImageURL, placeHolderImageName: "no_image_black")
    }

}
