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
    
    private let endpoint = "https://www.reddit.com/reddits.json"
    fileprivate let cacheService = AppCacheService()
    
    // MARK: - Methods
    
    func loadApps(completion: @escaping (ServiceResponse<App>) -> Void) {
        request(endpoint: endpoint) { [weak self] (dict, error) in
            DispatchQueue.main.async {
                guard let dict = dict else {
                    completion(ServiceResponse.failure(error: error))                    
                    return
                }
                let apps = self?.parse(dict)
                completion(.success(response: apps ?? []))
            }            
        }
    }
    
    func loadAppsWithCategoryNameFromCache(_ name: String) -> [App] {
        return cacheService.objects(predicateFormat: "r_category.r_name = '\(name)'") as! [App]
    }
    
    func loadAppsFromCache() -> [App] {
        return cacheService.objects() as! [App]
    }
    
    func loadCategoriesFromCache() -> [Category] {
        return cacheService.categoryObjects()
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
    
    func parse(_ json: Dictionary<String, Any>) -> [App] {
        
        var apps: [App] = Array()
        
        let data:       Dictionary<String, Any> = json["data"] as! Dictionary
        let children:   Array<Dictionary<String, Any>> = data["children"] as! Array
        
        for child in children
        {
            let interestingData: Dictionary<String, Any> = child["data"] as! Dictionary
            let newApp = parseApp(fromJson: interestingData)
            apps.append(newApp)
        }
        
        // Let's add apps to realm cache
        cacheService.add(objects: apps)
        
        return apps
    }
    
    private func parseApp(fromJson json: Dictionary<String, Any>) -> App {
        let app = RawApp(
            bannerImg: valueFor(json["banner_img"]),
            _id: valueFor(json["id"]),
            summitText: valueFor(json["submit_text"]),
            displayText: valueFor(json["display_name"]),
            title: valueFor(json["title"]),
            iconImg:   valueFor(json["icon_img"]),
            category: parseCategory(fromJson: json)
        )
        
        return app
    }
    
    private func parseCategory(fromJson json: Dictionary<String, Any>) -> Category {
        let name = valueFor(json["advertiser_category"]) ?? "Undefined"
        let newCategory = RawCategory(
            _id: name,
            name: name,
            imageName: imageNameFrom(name)
        )
        return newCategory
    }
    
    func valueFor(_ element:Any?) -> String? {
        return element as? String
    }
}
