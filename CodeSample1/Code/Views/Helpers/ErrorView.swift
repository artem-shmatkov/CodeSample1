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
        detail.numberOfLines = 3
        
        [title, detail].forEach { (label) in
            if let label = label {
                label.textColor = .white
                label.textAlignment = .center
                
                addSubview(label)
                
                label.translatesAutoresizingMaskIntoConstraints = false
                label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
                label.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
            }
        }
        
        layer.cornerRadius = 10
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    
    func update(_ error: Error?) {
        detail.text = error?.localizedDescription
    }
}
