//
//  Cache.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

protocol Cache {
    func objects() -> [Any]?
    func objects(predicateFormat: String, _ args: Any...) -> [Any]?
    
    func add(object: Any)
    func add(objects: [Any])
    func delete(object: Any)
    
    func deleteObjects(objects: [Any])
}
