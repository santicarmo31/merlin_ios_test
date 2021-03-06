//
//  AppsTableViewController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {
    
    // MARK: - Vars & Constants
    
    var dataSource: [App] = Array()
    var category: Category?
    var presenter: AppPresenter!
        
    let emptyMessageViewController = EmptyMessageViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        showApps()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath: IndexPath? = self.tableView.indexPathForSelectedRow
        
        if let controller: DetailTableViewController = segue.destination as? DetailTableViewController {
            controller.app = self.dataSource[indexPath!.row];
        }
    }
        
    // MARK: - Methods

    private func setupPresenter() {
        presenter = AppPresenter(view: self)
    }
    
    private func showApps() {
        if let categoryName = category?.name {
            presenter.showAppsForCategory(name: categoryName)
        } else {
            presenter.showApps()
        }
    }
    
    fileprivate func downloadImageFor(_ cell: AppTableViewCell, atIndexpath indexPath: IndexPath, fromUrl url: String?) {
        cell.appImage.setImage(fromUrl: url, placeHolderImageName: "no_image_black") { (image) in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    if let cell = self?.tableView.cellForRow(at: indexPath) as? AppTableViewCell {
                        cell.appImage.image = image
                    }
                }
            }
        }
    }
}

// MARK: - Table view data source

extension AppsTableViewController {
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
        
        appCell.setCellDataFrom(app: app)
        
        let rawImageURL = app.iconImg ?? app.bannerImg        
        downloadImageFor(appCell, atIndexpath: indexPath, fromUrl: rawImageURL)
        
        return appCell
    }
}

// MARK: - AppView Conformance

extension AppsTableViewController: AppView {
    func showEmptyApps(message: String) {
        emptyMessageViewController.message = message
        add(emptyMessageViewController)
    }
    
    func showEmptyCategories(message: String) {}
    
    func list(categories: [Category]) { }
    
    func list(apps: [App]) {
        emptyMessageViewController.remove()
        dataSource = apps
        tableView.reloadData()
    }
    
    func dataLoaded() {
        print("Cargue la data")
    }
}
