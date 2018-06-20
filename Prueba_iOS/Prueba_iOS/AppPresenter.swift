//
//  AppPresenter.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation

protocol AppView: BaseView {
    func list(categories: [Category])
    func list(apps: [App])
    func showEmptyCategories(message: String)
}

class AppPresenter {
    unowned var view: AppView
    private let service: AppService
    
    
    init(view: AppView, service: AppService = AppService()) {
        self.view = view
        self.service = service
    }
    
    func loadData() {
        view.startSpinner()
        service.loadApps { [weak self] (response) in
            self?.view.stopSpinner()
            if case .success = response {
                self?.showCategories()
            }
        }        
    }
    
    func showCategories() {
        let categories = service.loadCategoriesFromCache()
        let areCategoriesEmpty = categories.count == 0
        if areCategoriesEmpty {
            view.showEmptyCategories(message: "No hay categorias en el momento.")
        } else {
            view.list(categories: service.loadCategoriesFromCache())
        }
    }
    
    func showAppsForCategory(name: String) {
        view.list(apps: service.loadAppsWithCategoryName(name))
    }
    
    func showApps() {
        view.list(apps: service.loadAppsFromCache())
    }
    
}
