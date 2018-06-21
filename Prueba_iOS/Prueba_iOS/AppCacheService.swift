//
//  AppCacheService.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/20/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation
import RealmSwift

struct AppCacheService: Cache {
    
    func objects() -> [Any]? {
        let realmObjects = RealmManager.shared.all(for: RealmApp.self)
        return getModelObject(realmAppObjects: realmObjects)
    }
    
    func objects(predicateFormat: String, _ args: Any...) -> [Any]? {
        let realmObjects = RealmManager.shared.all(for: RealmApp.self, predicate: predicateFormat, args)
        return getModelObject(realmAppObjects: realmObjects)
    }
    
    func add(object: Any) {
        let app = object as! App
        let realmApp = parse(app)
        RealmManager.shared.add(objects: realmApp)
    }
    
    func add(objects: [Any]) {
        let realmApps = parse(objects as! [App])
        RealmManager.shared.clear()
        RealmManager.shared.add(objects: realmApps)
    }
    
    func delete(object: Any) {}
    
    func deleteObjects(objects: [Any]) {}
    
    
    func categoryObjects() -> [Category] {
        let realmObjects = RealmManager.shared.all(for: RealmCategory.self)
        return getModelObject(realmCategoryObjects: realmObjects)
    }
    
    func categoryObjects(predicateFormat: String, _ args: Any...) -> [Any]?  {
        let realmObjects = RealmManager.shared.all(for: RealmCategory.self, predicate: predicateFormat, args)
        return getModelObject(realmCategoryObjects: realmObjects)
    }
    
    private func parse(_ apps: [App]) -> [RealmApp] {
        return apps.map(parse)
    }
    
    private func parse(_ app: App) -> RealmApp {
        let realmApp = RealmApp()
        realmApp.r_id = app._id
        realmApp.r_bannerImg = app.bannerImg
        realmApp.r_displayText = app.displayText
        realmApp.r_iconImg = app.iconImg
        realmApp.r_title = app.title
        realmApp.r_summitText = app.summitText
        realmApp.r_category = parse(app.category)
        return realmApp
    }
    
    private func parse(_ category: Category?) -> RealmCategory? {
        if let category = category {
            let realmCategory = RealmCategory()
            realmCategory.r_id = category._id
            realmCategory.r_name = category.name
            realmCategory.r_imageName = category.imageName
            return realmCategory
        }
        return nil
    }
    
    private func getModelObject(realmAppObjects: [RealmApp]) -> [App] {
        return realmAppObjects.map(getModelObject)
    }
    
    private func getModelObject(realmApp: RealmApp) -> App {
        return RawApp(
            bannerImg: realmApp.bannerImg,
            _id: realmApp._id,
            summitText: realmApp.summitText,
            displayText: realmApp.displayText,
            title: realmApp.title,
            iconImg: realmApp.iconImg,
            category: realmApp.category
        )
    }
    
    private func getModelObject(realmCategoryObjects: [RealmCategory]) -> [Category] {
        return realmCategoryObjects.map(getModelObject)
    }
    
    private func getModelObject(realmCategoryObject: RealmCategory) -> Category {
        return RawCategory(
            _id: realmCategoryObject._id,
            name: realmCategoryObject.name,
            imageName: realmCategoryObject.imageName
        )
    }
}
