//
//  Router.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation
import UIKit

class Router: NSObject, ListRouterProtocol, CreateRouterProtocol {
    var tabController: UITabBarController!
    var listController: UINavigationController!
    
    var builder: Builder!
    var baseStorage: BaseListStorage!
    
    func start(window: UIWindow) {
        baseStorage = BaseListStorage.shared
        baseStorage.setup()
        
        builder = Builder()
        builder.baseStorage = baseStorage
            
        setupControllers()
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
    
    fileprivate func setupControllers() {
        tabController = UITabBarController()
        
        listController = builder.listModule(router: self)
        let serviceController = builder.serviceModule()
        tabController.viewControllers = [listController, serviceController]
    }
    
    // MARK: ListRouterProtocol
    
    func wantAddItem() {
        let createController = builder.createModule(router: self)
        listController.pushViewController(createController, animated: true)
    }
    
    func wantEditItem(id: Int) {
        let createController = builder.createModule(router: self, idToEdit: id)
        listController.pushViewController(createController, animated: true)
    }
    
    // MARK: CreateRouterProtocol
    
    func discardCreate() {
        listController.popViewController(animated: true)
    }
    
    func close() {
        listController.popViewController(animated: true)
    }
}
