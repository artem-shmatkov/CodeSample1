//
//  LoaderView.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class LoaderView: UIView {
    fileprivate var loader: UIActivityIndicatorView!
    
    func setup() {
        loader = UIActivityIndicatorView(style: .whiteLarge)
        addSubview(loader)
        
        loader.startAnimating()
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        layer.cornerRadius = 10
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
}
