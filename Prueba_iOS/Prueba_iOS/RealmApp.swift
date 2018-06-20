//
//  RealmApp.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation
import RealmSwift

class RealmApp: Object {
    dynamic var r_bannerImg: String?
    dynamic var r_id: String?
    dynamic var r_summitText: String?
    dynamic var r_displayText: String?
    dynamic var r_title: String?
    dynamic var r_iconImg: String?
    dynamic var r_category: RealmCategory?
    
    override static func primaryKey() -> String? {
        return "r_id"
    }
}

extension RealmApp: App {
    var bannerImg: String? {
        return r_bannerImg
    }
    
    var _id: String? {
        return r_id
    }
    
    var summitText: String? {
        return r_summitText
    }
    
    var displayText: String? {
        return r_displayText
    }
    
    var title: String? {
        return r_title
    }
    
    var iconImg: String? {
        return r_iconImg
    }
    
    var category: Category? {
        return RawCategory(
            _id: r_category?.r_id,
            name: r_category?.r_name,
            imageName: r_category?.r_imageName
        )
    }
    
    
}
