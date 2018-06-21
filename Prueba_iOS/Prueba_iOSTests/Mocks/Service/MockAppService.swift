//
//  MockAppService.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//


@testable import Prueba_iOS
import Foundation

class MockAppService: AppService {
    
    private let apps: [App]
    
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
    
}
