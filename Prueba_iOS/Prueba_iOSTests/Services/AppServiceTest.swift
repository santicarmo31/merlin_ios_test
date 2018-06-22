//
//  AppServiceTest.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/21/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Prueba_iOS

class AppServiceTest: XCTestCase {
    
    let appsJson = "Apps"
    
    var mockService = MockService()
    var service: AppService!
    
    override func setUp() {
        super.setUp()
        configureRealmForTests()
        service = AppService(service: mockService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func configureRealmForTests() {
        let schemaVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        
        var realmConfiguration = Realm.Configuration()
        realmConfiguration.inMemoryIdentifier = "prueba_ios_test"
        realmConfiguration.schemaVersion = UInt64(schemaVersion)!
        
        let realm = try! Realm(configuration: realmConfiguration)
        RealmManager.shared.context = realm
    }
    
    func testLoadApps() {
        let expectation = self.expectation(description: "serviceCalled")
        mockService.data = UtilsTest.loadJsonFile(json: appsJson)
        
        service.loadApps { (response) in
            switch response {
            case .success(let apps):
                XCTAssertGreaterThan(apps.count, 0, "apps shouldn't be 0")
            default:
                XCTAssertTrue(false, "Error in service")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.05, handler: nil)
    }
    
    func testLoadAppsFromCache() {
        let expectation = self.expectation(description: "serviceCalled")
        mockService.data = UtilsTest.loadJsonFile(json: appsJson)
        
        service.loadApps { (_) in
            let apps = self.service.loadAppsFromCache()
            XCTAssertGreaterThan(apps.count, 0, "apps shouldn't be 0")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.05, handler: nil)
    }
    
    func testLoadAppsWithCategoryNameFromCache() {
        let expectation = self.expectation(description: "serviceCalled")
        mockService.data = UtilsTest.loadJsonFile(json: appsJson)
        
        let categoryName = "Lifestyles"
        
        service.loadApps { (_) in
            let apps = self.service.loadAppsWithCategoryNameFromCache(categoryName)
            XCTAssertGreaterThan(apps.count, 0, "apps shouldn't be 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.05, handler: nil)
    }
    
    func testLoadCategoriesFromCache() {
        let expectation = self.expectation(description: "serviceCalled")
        mockService.data = UtilsTest.loadJsonFile(json: appsJson)
        
        service.loadApps { (_) in
            let categories = self.service.loadCategoriesFromCache()
            XCTAssertGreaterThan(categories.count , 0, "categories shouldn't be 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.05, handler: nil)
    }
}
