//
//  UIImageView+ImageHandler.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

extension UIImageView {
    func setImage(fromUrl url: String?, placeHolderImageName placeHolder: String = "no_image_black", completion: @escaping (UIImage?) -> Void) {
        let placeHolderImage = UIImage(named: placeHolder)
       
        image = placeHolderImage
        
        let imageHandler = ImageCacheHandler()
        imageHandler.imageForUrl(url, andReturn: completion)
    }
}
