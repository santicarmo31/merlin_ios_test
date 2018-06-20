//
//  Category.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

protocol Category {
    var _id: String? { get }
    var name: String? { get }
    var imageName: String? { get }
}

struct RawCategory: Category {
    var _id: String?
    var name: String?
    var imageName: String?
}
