//
//  Builder.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class Builder {
    var baseStorage: BaseListStorageProtocol!
    
    func listModule(router: ListRouterProtocol) -> UINavigationController {
        let store = ListStore()
        let interactor = ListInteractor()
        let viewController = ListViewController()
        
        store.baseStorage = baseStorage
        
        interactor.store = store
        interactor.router = router
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
    
    func createModule(router: ItemRouterProtocol, idToEdit: Int = -1) -> ItemViewController {
        let store = ItemStore()
        let interactor = ItemInteractor()
        let viewController = ItemViewController()
        
        store.baseStorage = baseStorage
        
        interactor.idToEdit = idToEdit
        interactor.store = store
        interactor.router = router
        interactor.view = viewController
        
        viewController.interactor = interactor
        
        return viewController
    }
}
