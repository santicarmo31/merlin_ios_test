//
//  CategoriesTableViewIpadController.swift
//  Prueba_iOS
//
//  Created by Humberto Cetina on 2/27/17.
//  Copyright © 2017 Humberto Cetina. All rights reserved.
//

import UIKit
import AFNetworking

protocol IpadCategorySelectionDelegate: class {
    func categorySelected(_ category: Category?)
}

class CategoriesTableViewIpadController: CategoriesTableViewController {
    
    // MARK: - Vars & Constants
    
    weak var categorySelectionDelegate: IpadCategorySelectionDelegate?
    
    // MARK: - Life Cycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

// MARK: - Table view delegate

extension CategoriesTableViewIpadController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let didSelectShowAllRow = indexPath.row == 0
        let categorySelected = didSelectShowAllRow ? nil : self.dataSource[indexPath.row - 1]
        categorySelectionDelegate?.categorySelected(categorySelected)
    }
}

