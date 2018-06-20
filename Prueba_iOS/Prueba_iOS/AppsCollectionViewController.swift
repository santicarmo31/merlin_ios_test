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
    var emptyMessageView: UILabel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupNavigationControllerBar()
        addEmptyMessageView()
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
    
    private func addEmptyMessageView() {
        let message = "No se ha seleccionado ninguna categoria"
        emptyMessageView = UILabel(frame: CGRect.zero)
        emptyMessageView?.textAlignment = .center
        emptyMessageView?.text = message
        
        view.addSubview(emptyMessageView!)
        
        emptyMessageView!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutAttribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: emptyMessageView!, attribute: $0, relatedBy: .equal, toItem: emptyMessageView!.superview, attribute: $0, multiplier: 1, constant: 0)
        })        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
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
            self?.emptyMessageView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self?.emptyMessageView?.alpha = 0.0
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
