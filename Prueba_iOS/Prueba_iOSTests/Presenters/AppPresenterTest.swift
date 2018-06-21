//
//  AppPresenterTest.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

@testable import Prueba_iOS
import XCTest

class AppPresenterTest: XCTestCase {
    
    let mockAppView = MockAppView()
    var mockAppService: MockAppService!
    var appPresenterTest: AppPresenter!
    
    override func setUp() {
        super.setUp()
        let apps = UtilsTest.getMockApps()
        mockAppService = MockAppService(apps: apps)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
