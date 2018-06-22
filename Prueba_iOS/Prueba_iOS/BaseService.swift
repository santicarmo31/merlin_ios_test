//
//  BaseService.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation
import AFNetworking

enum ServiceResponse<Model> {
    case success(response: [Model])
    case failure(error: Error?)    
}


class BaseService<Model> {
    
    // MARK: - Vars & Constants
    
    let service: Service
    
    // MARK: - LifeCycle
    
    init(service: Service = NetworkHandler()) {
        self.service = service
    }
    
    func request(endpoint: String, params: [String : Any]? = nil, completion: @escaping ([String : Any]?, Error?) -> Void) {
        service.request(endpoint: endpoint, params: params, completion: completion)
    }
    
    func parse(response: Any) -> [Model]? {
        return nil
    }
}
