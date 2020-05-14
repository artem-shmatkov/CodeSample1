//
//  Router.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation
import UIKit

class Router: NSObject {
    var tabController: UITabBarController!
    var builder: Builder!
    
    func start(window: UIWindow) {
        builder = Builder()
        
        setupControllers()
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
    
    fileprivate func setupControllers() {
        tabController = UITabBarController()
        
        let listController = builder.listModule()
        let serviceController = builder.serviceModule()
        tabController.viewControllers = [listController, serviceController]
    }
}
