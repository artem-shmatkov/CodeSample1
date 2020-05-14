//
//  ErrorView.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class ErrorView: UIView {
    fileprivate var title: UILabel!
    fileprivate var detail: UILabel!
    
    func setup() {
        title = UILabel()
        detail = UILabel()
        
        title.text = ui.string.common.error
        
        title.textColor = .white
        detail.textColor = .white
        
        title.textAlignment = .center
        detail.textAlignment = .center
        
        addSubview(title)
        addSubview(detail)
        
        detail.numberOfLines = 3
        
        title.translatesAutoresizingMaskIntoConstraints = false
        detail.translatesAutoresizingMaskIntoConstraints = false
        
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        detail.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        detail.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        
        title.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        detail.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        
        layer.cornerRadius = 10
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    
    func update(_ error: Error?) {
        detail.text = error?.localizedDescription
    }
}
