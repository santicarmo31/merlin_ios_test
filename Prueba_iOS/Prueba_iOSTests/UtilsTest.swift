//
//  UtilsTest.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

@testable import Prueba_iOS
import Foundation

class UtilsTest {   
    
    static func loadJsonFile(json: String) -> [String: AnyObject] {
        var data = Data()
        
        if let url = Bundle(for: UtilsTest.self).url(forResource: json, withExtension: "json") {
            do {
                data = try Data(contentsOf: url as URL)
            } catch {
                print("Error cargando el json: \(json)")
            }
        }
        
        guard let json = getData(mockData: data) else {
            return [:]
        }
        
        return json
    }
    
    static func getData(mockData: Data) -> [String: AnyObject]? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: mockData, options: .allowFragments)
            if let dictionary = json as? [String: AnyObject] {
                return dictionary
            }
        } catch {
            print("Error serializando el json")
        }
        return nil
    }
}
