//
//  DatabaseProtocol.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

typealias Database = ReadableDatabase & WritableDatabase

protocol ReadableDatabase {
    func loadObjects<Model>(offType type: Model.Type, matching query: String?, params: [Any]?) -> [Model]
    func loadObject<Type>(withId id: String) -> Type?
}

protocol WritableDatabase {
    func add<Type>(_ object: Type) -> Bool
    func delete<Type>(_ object: Type) -> Bool
}
