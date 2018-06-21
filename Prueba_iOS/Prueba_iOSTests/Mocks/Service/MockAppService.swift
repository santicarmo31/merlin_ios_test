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
    
    var apps: [App]
    
    init(apps: [App]? = nil) {
        let mockApps = [
            RawApp(
                bannerImg: "https://a.thumbs.redditmedia.com/kcKnQt4TInkTARtKtsyRhvs5g3bdkVXq8wSJF6gDH20.png", _id: "2qh0u",
                summitText: "Mock0",
                displayText: "Mock0",
                title: "Mock0",
                iconImg: "Mock0",
                category: RawCategory(
                    _id: "Mock0",
                    name: "Mock0",
                    imageName: "Mock0"
                )
            ),
            RawApp(
                bannerImg: "https://a.thumbs.redditmedia.com/kcKnQt4TInkTARtKtsyRhvs5g3bdkVXq8wSJF6gDH20.png", _id: "2qh0u",
                summitText: "Mock1",
                displayText: "Mock1",
                title: "Mock1",
                iconImg: "Mock1",
                category: RawCategory(
                    _id: "Mock1",
                    name: "Mock1",
                    imageName: "Mock1"
                )
            ),
            RawApp(
                bannerImg: "https://a.thumbs.redditmedia.com/kcKnQt4TInkTARtKtsyRhvs5g3bdkVXq8wSJF6gDH20.png", _id: "2qh0u",
                summitText: "Mock2",
                displayText: "Mock2",
                title: "Mock2",
                iconImg: "Mock2",
                category: RawCategory(
                    _id: "Mock2",
                    name: "Mock2",
                    imageName: "Mock2"
                )
            )
        ]
        
        self.apps = apps ?? mockApps
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
    
    override func loadAppsWithCategoryNameFromCache(_ name: String) -> [App] {
        return apps.filter({ $0.category?._id == name })
    }
    
}
