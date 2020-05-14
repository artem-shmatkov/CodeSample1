//
//  ListTableCell.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

typealias ListCellHandler = (_ id: Int, _ selected: Bool) -> Void

class ListTableCell: UITableViewCell {
    fileprivate var switchView: UISwitch!
    fileprivate var id = 0
    
    var handler: ListCellHandler!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSwitch()
        selectionStyle = .none
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
        
        switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    func update(model: ListItemModel) {
        id = model.id
        textLabel?.text = model.name
        switchView.isOn = model.selected
        
        imageView?.image = switchView.isOn ? ui.image.listCell.selected : ui.image.listCell.normal
    }
    
    // MARK: Actions
    
    @objc func switchChanged() {
        imageView?.image = switchView.isOn ? ui.image.listCell.selected : ui.image.listCell.normal
        handler(id, switchView.isOn)
    }
}
