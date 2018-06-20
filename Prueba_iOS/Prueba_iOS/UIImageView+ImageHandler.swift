//
//  UIImageView+ImageHandler.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIImageView {
    func setImage(fromUrl url: String?, placeHolderImageName placeHolder: String = "no_image_black") {
        let placeHolderImage = UIImage(named: placeHolder)
        if image == nil && image != placeHolderImage {
            image = placeHolderImage
        }
        
        let imageHandler = ImageCacheHandler()
        imageHandler.imageForUrl(url, andReturn: { (image) in
            if let image = image {
                self.image = image
            }
        })
    }
}
