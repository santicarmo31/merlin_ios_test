//
//  App.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

protocol App {
    var bannerImg: String? { get }
     var _id: String? { get }
     var summitText: String? { get }
     var displayText: String? { get }
     var title: String? { get }
     var iconImg: String? { get }
     var category: Category? { get }
}

struct RawApp: App {
    var bannerImg: String?
    var _id: String?
    var summitText: String?
    var displayText: String?
    var title: String?
    var iconImg: String?
    var category: Category?
}
