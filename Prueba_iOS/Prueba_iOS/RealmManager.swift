//
//  RealmManager.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    
    fileprivate var context: Realm!
    
    private init() {
        do {
            self.context = try Realm()
        } catch let error as NSError {
            assertionFailure("Somethig went wrong with Realm, error = \(error.description)")
        }
    }

    public func add(object: Object, update: Bool = true) {
        if context.isInWriteTransaction {
            context.add(object, update: update)
        } else {
            try! context.write {
                context.add(object, update: update)
            }
        }
    }
    
    public func add(objects: Object..., update: Bool = true) {
        add(objects: objects)
    }
    
    public func add(objects: [Object], update: Bool = true) {
        for object in objects {
            add(object: object, update: update)
        }
    }
    
    public func all<Model: Object>(for type: Model.Type, predicate: String? = nil, _ args: Any...) -> [Model] {
        let objects = context.objects(type)
        
        if let predicateFormat = predicate {
            return Array(objects.filter(predicateFormat, args))
        }
        
        return Array(objects)
    }
    
    public func delete(object: Object) {
        try! context.write {
            context.delete(object)
        }
    }
    
    public func clear() {
        try! context.write {
            context.deleteAll()
        }
    }

}

