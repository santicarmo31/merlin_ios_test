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
        mockAppService = MockAppService(apps: mockApps)
        appPresenterTest = AppPresenter(view: mockAppView, service: mockAppService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldListCategories() {
        appPresenterTest.showCategories()
        XCTAssert(mockAppView.listCategoriesCalled, "list categories hasn't been called in view")
    }
    
    func testShouldListApps() {
        appPresenterTest.showApps()
        XCTAssert(mockAppView.listAppsCalled, "list apps hasn't been called in view")
    }
        
    
    func testShouldListAppsForCategory() {
        appPresenterTest.showAppsForCategory(name: "Mock0")
        XCTAssert(mockAppView.listAppsCalled, "list apps hasn't been called in view")
    }
    
    func testShouldShowEmptyCategoriesMessage() {
        mockAppService.apps = []
        appPresenterTest.showCategories()
        XCTAssert(mockAppView.showEmptyCategoriesCalled, "showEmptyCategories hasn't been called in view")
    }
    
    func testShouldShowAppsForCategoryEmptyMessage() {
        let categoryName = "O"
        let expectedAppsForCategoryEmptyMessage = String(format: appPresenterTest.emptyAppsForCategoryMessage, categoryName)
        
        appPresenterTest.showAppsForCategory(name: categoryName)
        XCTAssert(mockAppView.showEmptyAppsCalled, "showEmptyApps hasn't been called in view")
        XCTAssertEqual(mockAppView.emptyAppsMessage, expectedAppsForCategoryEmptyMessage, "emptyMessage should be: \(expectedAppsForCategoryEmptyMessage)")
    }
    
    func testShouldShowAppsEmptyMessage() {
        let expectedShowAppEmptyMessage = appPresenterTest.emptyAppsMessage
        mockAppService.apps = []
        appPresenterTest.showApps()
        
        XCTAssert(mockAppView.showEmptyAppsCalled, "showEmptyApps hasn't been called in view")
        XCTAssertEqual(mockAppView.emptyAppsMessage, expectedShowAppEmptyMessage, "emptyMessage should be: \(expectedShowAppEmptyMessage)")
    }
    
}
