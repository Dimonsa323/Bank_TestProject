//
//  TableView+Extension.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 17.04.2023.
//

import UIKit

public extension UITableView {

    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    func registerCellProgramically(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(type, forCellReuseIdentifier: identifier ?? cellId)
    }

    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }

    /**
     DequeueCell by passing the type of UITableViewCell
     - Parameter type: UITableViewCell.Type
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }

    /**
     DequeueCell by passing the type of UITableViewCell and IndexPath
     - Parameter type: UITableViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }

}

public extension UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}

