//
//  NetworkHandler.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class NetworkHandler: NSObject, Service {
    
    func request(endpoint: String, params: [String : Any]?, completion: @escaping ([String : Any]?, Error?) -> Void) {
        let sesion: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        let set: CharacterSet = CharacterSet.urlQueryAllowed
        let encondedUrlString: String = endpoint.addingPercentEncoding(withAllowedCharacters: set)!
        let url: URL = URL(string: encondedUrlString)!
        
        let task: URLSessionDataTask = sesion.dataTask(with: url) { (data, urlResponse, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            do
            {
                if let data = data {
                    let jsonDic: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    completion(jsonDic as? Dictionary<String, Any>, nil);
                } else {
                    completion(nil, nil)
                }
            }
            catch
            {
                completion(nil, nil);
            }
        };
        
        task.resume();
    }
}
