//
//  Builder.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class Builder: NSObject {
    func listModule() -> UINavigationController {
        let store = ListStore()
        let interactor = ListInteractor()
        let viewController = ListViewController()
        
        interactor.store = store
        interactor.view = viewController
        
        viewController.interactor = interactor
        
        let nc = UINavigationController(rootViewController: viewController)
        nc.tabBarItem = UITabBarItem(title: ui.string.common.list, image: ui.image.tabbar.list.normal, selectedImage: ui.image.tabbar.list.selected)
        
        return nc
    }
    
    func serviceModule() -> UINavigationController {
        let store = ServiceStore()
        let interactor = ServiceInteractor()
        let viewController = ServiceViewController()
        
        interactor.store = store
        interactor.view = viewController
        
        viewController.interactor = interactor
        
        let nc = UINavigationController(rootViewController: viewController)
        nc.tabBarItem = UITabBarItem(title: ui.string.common.service, image: ui.image.tabbar.service.normal, selectedImage: ui.image.tabbar.service.selected)
        
        return nc
    }
    
    func createModule() -> CreateViewController {
        let store = CreateStore()
        let interactor = CreateInteractor()
        let viewController = CreateViewController()
        
        interactor.store = store
        interactor.view = viewController
        
        viewController.interactor = interactor
        
        return viewController
    }
}
