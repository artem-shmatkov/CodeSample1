//
//  ServiceTableCell.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class ServiceTableCell: UITableViewCell {
    func update(model: ServiceItemModel) {
        self.textLabel?.text = model.title
    }
}
