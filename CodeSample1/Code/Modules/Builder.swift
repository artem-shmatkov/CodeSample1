//
//  Builder.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class Builder: NSObject {
    func listModule() -> ListViewController {
        let store = ListStore()
        let interactor = ListInteractor()
        let viewController = ListViewController()
        
        interactor.store = store
        interactor.view = viewController
        
        viewController.interactor = interactor
        viewController.tabBarItem = UITabBarItem(title: "List", image: nil, selectedImage: nil)
        
        return viewController
    }
    
    func serviceModule() -> ServiceViewController {
        let store = ServiceStore()
        let interactor = ServiceInteractor()
        let viewController = ServiceViewController()
        
        interactor.store = store
        interactor.view = viewController
        
        viewController.interactor = interactor
        viewController.tabBarItem = UITabBarItem(title: "Service", image: nil, selectedImage: nil)
        
        return viewController
    }
}
