//
//  ListTableCell.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class ListTableCell: UITableViewCell {
    fileprivate var switchView: UISwitch!
    fileprivate var id = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSwitch() {
        switchView = UISwitch()
        contentView.addSubview(switchView)
        
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        switchView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func update(model: ListItemModel) {
        id = model.id
        textLabel?.text = model.name
        switchView.isOn = model.selected
    }
}
