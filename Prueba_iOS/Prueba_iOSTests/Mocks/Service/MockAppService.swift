//
//  MockAppService.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//



import Foundation
@testable import Prueba_iOS

class MockAppService: AppService {
    
    var apps: [App]
    
    init(apps: [App]) {
        self.apps = apps
    }
    
    override func loadAppsFromCache() -> [App] {
        return apps
    }
    
    override func loadCategoriesFromCache() -> [Prueba_iOS.Category] {
        return apps.flatMap({ $0.category })
    }
    
    override func loadApps(completion: @escaping (ServiceResponse<App>) -> Void) {
        completion(.success(response: apps))
    }
    
    override func loadAppsWithCategoryNameFromCache(_ name: String) -> [App] {
        return apps.filter({ $0.category?._id == name })
    }
    
}
