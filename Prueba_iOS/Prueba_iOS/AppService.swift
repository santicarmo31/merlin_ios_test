//
//  AppService.swift
//  Prueba_iOS
//
//  Created by Santiago Carmona Gonzalez on 6/19/18.
//  Copyright © 2018 Humberto Cetina. All rights reserved.
//

import Foundation


class AppService: BaseService<App> {
    
    // MARK: - Vars & Constants
    
    let endpoint = "https://www.reddit.com/reddits.json"
    
    // MARK: - Methods
    
    func loadApps(completion: @escaping (ServiceResponse<App>) -> Void) {
        request(endpoint: endpoint) { [weak self] (dict, error) in
            DispatchQueue.main.async {
                guard let dict = dict else {
                    completion(ServiceResponse.failure(error: error))                    
                    return
                }
                let apps = self?.createLocalDataBaseWith(dict)
                completion(.success(response: apps ?? []))
            }            
        }
    }
    
    func loadAppsWithCategoryName(_ name: String) -> [App] {
        let pred: NSPredicate = NSPredicate(format: "r_category.r_name = %@", name)
        return RealmManager.shared.all(for: RealmApp.self, predicate: pred)
    }
    
    func loadAppsFromCache() -> [App] {
        return RealmManager.shared.all(for: RealmApp.self)
    }
    
    func loadCategoriesFromCache() -> [Category] {
        return RealmManager.shared.all(for: RealmCategory.self)
    }
}

extension AppService {
    
    func imageNameFrom(_ categoryName:String) -> String?{
        
        var imageName: String? = nil
        
        switch categoryName {
        case "Undefined":
            imageName = "undefined_image"
        case "Sports":
            imageName = "sport_image"
        case "Games":
            imageName = "games_image"
        case "Lifestyles":
            imageName = "life_style_image"
        case "Entertainment":
            imageName = "entertainment_image"
        default:
            return nil
        }
        
        return imageName
    }
    
    func createLocalDataBaseWith(_ json: Dictionary<String, Any>) -> [App] {
        
        var apps: [App] = Array()
        
        RealmManager.shared.clear()
        
        let data:       Dictionary<String, Any> = json["data"] as! Dictionary
        let children:   Array<Dictionary<String, Any>> = data["children"] as! Array
        
        for child in children
        {
            let interestingData: Dictionary<String, Any> = child["data"] as! Dictionary
            let newApp = parseApp(fromJson: interestingData)
            
            RealmManager.shared.add(object: newApp)
            apps.append(newApp)
        }
        
        return apps
    }
    
    private func parseApp(fromJson json: Dictionary<String, Any>) -> RealmApp {
        let app = RealmApp()
        
        app.r_id = valueFor(json["id"])
        app.r_title = valueFor(json["title"])
        app.r_iconImg = valueFor(json["icon_img"])
        app.r_displayText = valueFor(json["display_name"])
        app.r_summitText = valueFor(json["submit_text"])
        app.r_bannerImg = valueFor(json["banner_img"])
        
        let category: RealmCategory = parseCategory(fromJson: json)
        app.r_category = category
        
        return app
    }
    
    private func parseCategory(fromJson json: Dictionary<String, Any>) -> RealmCategory {
        let name = valueFor(json["advertiser_category"]) ?? "Undefined"
        let newCategory: RealmCategory = RealmCategory()
        newCategory.r_id = name
        newCategory.r_imageName = imageNameFrom(name)
        newCategory.r_name = name
        return newCategory
    }
    
    func valueFor(_ element:Any?) -> String? {
        return element as? String
    }
}
