//
//  CategoriesViewController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    // MARK: - Vars & Constants
    
    var dataSource: [Category] = Array()
    var presenter: AppPresenter!
        
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupPresenter()
        observeNetworkStatus()
        presenter.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath: IndexPath = self.tableView.indexPathForSelectedRow {
            let didSelectShowAllRow = indexPath.row == 0
            let categorySelected = didSelectShowAllRow ? nil : self.dataSource[indexPath.row - 1]
            if segue.identifier == "ShowApp" {
                let controller: AppsTableViewController = segue.destination as! AppsTableViewController
                controller.category = categorySelected
            }
        }
    }
    
    // MARK: - Methods
    
    private func setupTableview() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func setupPresenter() {
        presenter = AppPresenter(view: self)        
    }
    
    
    override func networkNotReachable() {
        let message: AGPushNote = AGPushNote()
        message.setDefaultUI()
        message.message = "Funcionando en modo Offline"
        message.iconImage = UIImage(named: "no_wifi")
        message.showAtBottom = true
        
        AGPushNoteView.showNotification(message)
        AGPushNoteView.setCloseAction({})
        AGPushNoteView.setMessageAction({ (pushNote) in })
        
        presenter.showCategories()
    }
    override func networkReachable() {
        AGPushNoteView.close(completion: {})
        presenter.loadData()
    }
}

// MARK: - Table view data source

extension CategoriesTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 67.0;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let categoryCell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        let isFirstRow = indexPath.row == 0
        
        if isFirstRow {
            categoryCell.categoryLabel.text = "Mostrar todo"
            categoryCell.categoryImage.image = UIImage(named: "all_iphone_image")
        } else {
            let category: Category = dataSource[indexPath.row - 1]
            categoryCell.categoryLabel.text = (category.name == "Undefined") ? "Sin Categoría" : category.name
            categoryCell.categoryImage.image = UIImage(named: category.imageName ?? "")
        }
        return categoryCell
    }
}

// MARK: - AppView Conformance

extension CategoriesTableViewController: AppView {
    func showEmptyApps(message: String) {}
    
    func showEmptyCategories(message: String) {
        showEmptyMessage(message)
    }
    
    func list(apps: [App]) {}
    
    func list(categories: [Category]) {
        hideEmptyMessage()
        self.dataSource = categories
        self.tableView.reloadData()
    }
}
