//
//  ListTableCell.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class ListTableCell: UITableViewCell {
    func update(model: ListItemModel) {
        self.textLabel?.text = model.name
    }
}
