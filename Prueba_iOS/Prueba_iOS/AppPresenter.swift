//
//  AppPresenter.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

protocol AppView: class {
    func list(categories: [Category])
    func list(apps: [App])
    func dataLoaded()
}

class AppPresenter {
    unowned var view: AppView
    private let service: AppService // In the future we can change this service from SQL, FireBase or whatever
    
    
    init(view: AppView, service: AppService = AppService()) {
        self.view = view
        self.service = service
    }
    
    func loadData() {
        self.service.loadApps { (response) in
            if case .success = response {
                self.showCategories()
            }
        }        
    }
    
    func showCategories() {
        view.list(categories: service.loadCategoriesFromCache())
    }
    
    func showAppsForCategory(name: String) {
        view.list(apps: service.loadAppsWithCategoryName(name))
    }
    
    func showApps() {
        view.list(apps: service.loadAppsFromCache())
    }
    
}
