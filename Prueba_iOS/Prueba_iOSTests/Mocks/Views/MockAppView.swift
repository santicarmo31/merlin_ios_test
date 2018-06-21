//
//  MockAppView.swift
//  Prueba_iOSTests
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//


@testable import Prueba_iOS
import Foundation

class MockAppView: AppView {
    
    var listCategoriesCalled = false
    var listAppsCalled = false
    var showEmptyCategoriesCalled = false
    var showEmptyAppsCalled = false
    var startSpinnerCalled = false
    var stopSpinnerCalled = false
    
    var emptyAppsMessage: String?
    
    init() {
    }
    
    func list(categories: [Prueba_iOS.Category]) {
        listCategoriesCalled = true
    }
    
    func list(apps: [App]) {
        listAppsCalled = true
    }
    
    func showEmptyCategories(message: String) {
        showEmptyCategoriesCalled = true
    }
    
    func showEmptyApps(message: String) {
        showEmptyAppsCalled = true
        emptyAppsMessage = message
    }
    
    func startSpinner() {
        startSpinnerCalled = true
    }
    
    func stopSpinner() {
        stopSpinnerCalled = true
    }
    
}
