//
//  BaseService.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

class BaseService<Model> {
    
    let networkHandler: NetworkHandler = NetworkHandler()
    
    func request(endpoint: String, params: [String: Any]? = nil, completion: @escaping (Dictionary<String, Any>?, _ error: Error?) -> Void) {
        networkHandler.jSonWith(endpoint, andReturn: completion)
    }
    
    func parse(response _: AnyObject) -> [Model]? {
        return nil
    }
    
}
