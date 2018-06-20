//
//  AppsTableViewController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {

    var dataSource: [App] = Array()
    var imageHandler: ImageCacheHandler = ImageCacheHandler()
    var category: Category?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if (self.category != nil)
        {
            let pred: NSPredicate = NSPredicate(format: "r_category.r_name = %@", self.category!.name!)
            self.dataSource =  RealmManager.shared.all(for: RealmApp.self, predicate: pred)
        }
        else
        {
            self.dataSource =  RealmManager.shared.all(for: RealmApp.self)
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let appCell: AppTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppTableViewCell
        let app: App = self.dataSource[indexPath.row]
        
        appCell.appTitle.text = app.title
        appCell.appDescription.text = app.summitText
        appCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        var imageUlr: String?
        
        if let iconImg = app.iconImg
        {
            imageUlr = iconImg
        }
        else if let bannerImg = app.bannerImg
        {
            imageUlr = bannerImg
        }
        
        self.imageHandler.imageForUrl(imageUlr, andReturn: { (image) in
            DispatchQueue.main.async {
                
                
                if image == nil
                {
                    appCell.appImage.image = UIImage(named: "no_image_black")
                }
                else
                {
                    appCell.appImage.image = image
                }
            }
        })
        
        return appCell
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath: IndexPath? = self.tableView.indexPathForSelectedRow;
        let controller: DetailTableViewController = segue.destination as! DetailTableViewController
        controller.app = self.dataSource[indexPath!.row];
    }
}
