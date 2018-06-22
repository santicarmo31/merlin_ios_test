//
//  MockService.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/21/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation
@testable import Prueba_iOS

class MockService: Service {
    
    var data: [String: Any]?
    var error: Error?
    
    func request(endpoint: String, params: [String : Any]?, completion: @escaping ([String : Any]?, Error?) -> Void) {
        completion(data, error)
    }
}
