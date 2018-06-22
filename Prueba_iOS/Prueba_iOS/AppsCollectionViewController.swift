//
//  AppsCollectionViewController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit

class AppsCollectionViewController: UICollectionViewController {
    
    // MARK: - Vars & Constants
    
    var dataSource: [App] = Array()
    var presenter: AppPresenter!
    var category: Category?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupNavigationControllerBar()
        showEmptyMessage("No se ha seleccionado ninguna categoria")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPaths: Array? = self.collectionView?.indexPathsForSelectedItems;
        let indexPath: IndexPath? = indexPaths?.first;
        
        let navController: UINavigationController =  segue.destination as! UINavigationController
        let controller: DetailTableViewController = navController.viewControllers.first as! DetailTableViewController
        controller.app = self.dataSource[indexPath!.row];
    }
    
    // MARK: - Methods
    
    private func setupPresenter() {
        presenter = AppPresenter(view: self)
        presenter.title2 = "AppCollection"
    }
    
    private func setupNavigationControllerBar() {
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem;
        self.navigationItem.leftItemsSupplementBackButton = true;
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "shadow"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage();
        
        if ((self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone && self.traitCollection.displayScale == 3.0))
        {
            self.navigationController?.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "shadow"), for: UIBarMetrics.default)
            self.navigationController?.navigationController?.navigationBar.shadowImage = UIImage();
        }
    }
    
    fileprivate func showApps() {
        if let categoryName = category?.name {
            presenter.showAppsForCategory(name: categoryName)
        } else {
            presenter.showApps()
        }
    }
    
    fileprivate func downloadImageFor(_ cell: AppCollectionViewCell, atIndexpath indexPath: IndexPath, fromUrl url: String?) {
        cell.appImage.setImage(fromUrl: url, placeHolderImageName: "no_image_black") { (image) in
            guard let image = image else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                let cell = self?.collectionView?.cellForItem(at: indexPath) as? AppCollectionViewCell
                cell?.appImage.image = image
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension AppsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath)
        let appCell: AppCollectionViewCell = cell as! AppCollectionViewCell
        let app: App = self.dataSource[indexPath.row]
        
        appCell.setCellDataFrom(app: app)
        
        return appCell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let appCell: AppCollectionViewCell = cell as? AppCollectionViewCell {
            let app: App = self.dataSource[indexPath.row]
            
            let rawImageURL = app.iconImg ?? app.bannerImg
            downloadImageFor(appCell, atIndexpath: indexPath, fromUrl: rawImageURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 182)
    }
    
    override func navigationShouldPopOnBackButton() -> Bool {
        
        if ((self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone && self.traitCollection.displayScale == 3.0))
        {
            self.navigationController?.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationController?.navigationBar.shadowImage = nil;
        }
        
        return true;
    }
}

// MARK: - Ipad category selection delegate

extension AppsCollectionViewController: IpadCategorySelectionDelegate {
    func categorySelected(_ category: Category?) {
        UIView.animate(withDuration: 0.30, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.hideEmptyMessage()
        }) { [weak self] (finished) in
            if finished {
                self?.category = category
                self?.showApps()
            }
        }
    }
}

// MARK: - AppView Conformance

extension AppsCollectionViewController: AppView {
    func showEmptyApps(message: String) {
        showEmptyMessage(message)
    }
    
    func showEmptyCategories(message: String) {}
    
    func list(categories: [Category]) { }
    
    func list(apps: [App]) {
        dataSource = apps
        collectionView?.reloadData()
    }
    
    func dataLoaded() {
        print("Cargue la data")
    }
}
