//
//  ServiceViewController.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class ServiceViewController: UIViewController, ServiceViewProtocol {
    var interactor: ServiceInteractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
