//
//  RealmCategory.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCategory: Object {
    
    dynamic var r_id: String?
    dynamic var r_name: String?
    dynamic var r_imageName: String?
    
    override static func primaryKey() -> String? {
        return "r_id"
    }
}

extension RealmCategory: Category {
    var _id: String? {
        return r_id
    }
    
    var name: String? {
        return r_name
    }
    
    var imageName: String? {
        return r_imageName
    }
    
}
