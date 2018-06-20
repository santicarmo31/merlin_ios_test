//
//  CategoriesViewController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit
import AFNetworking

class CategoriesTableViewController: UITableViewController {

    var dataSource: [Category] = Array()
    var presenter: AppPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        
        presenter.loadData()
        
//        let manager: AFNetworkReachabilityManager = AFNetworkReachabilityManager.shared()
//        manager.setReachabilityStatusChange { (status) in
//
//            if status == AFNetworkReachabilityStatus.notReachable
//            {
//                let message: AGPushNote = AGPushNote()
//                message.setDefaultUI()
//                message.message = "Funcionando en modo Offline"
//                message.iconImage = UIImage(named: "no_wifi")
//                message.showAtBottom = true
//
//                AGPushNoteView.showNotification(message)
//                AGPushNoteView.setCloseAction({})
//                AGPushNoteView.setMessageAction({ (pushNote) in })
//                self.loadObjects()
//            }
//            else
//            {
//                AGPushNoteView.close(completion: {})
//                self.presenter.showCategories()
//            }
//        };
        
//        manager.startMonitoring()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 67.0;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let categoryCell: CategoryTableViewCell = cell as! CategoryTableViewCell
        
        if (indexPath.row == 0)
        {
            categoryCell.categoryLabel.text = "Mostrar todo"
            categoryCell.categoryImage.image = UIImage(named: "all_iphone_image")
        }
        else
        {
            let category: Category = dataSource[indexPath.row - 1]
            categoryCell.categoryLabel.text = (category.name == "Undefined") ? "Sin Categoría" : category.name
            categoryCell.categoryImage.image = UIImage(named: category.imageName ?? "")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath: IndexPath? = self.tableView.indexPathForSelectedRow;
        
        if (segue.identifier == "ShowApp")
        {
            let controller: AppsTableViewController = segue.destination as! AppsTableViewController
            controller.category = (indexPath!.row == 0) ? nil : self.dataSource[indexPath!.row - 1];
        }
    }
    
    private func setupPresenter() {
        presenter = AppPresenter(view: self)
    }
}

extension CategoriesTableViewController: AppView {
    func dataLoaded() {
        print("Cargue la data")
    }
    
    func list(apps: [App]) {}
    
    func list(categories: [Category]) {        
            self.dataSource = categories
            self.tableView.reloadData()
    }
}

