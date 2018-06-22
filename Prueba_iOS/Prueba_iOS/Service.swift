//
//  Service.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/21/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation


protocol Service {
    func request(endpoint: String, params: [String: Any]?, completion: @escaping ([String: Any]?, _ error: Error?) -> Void)
}
