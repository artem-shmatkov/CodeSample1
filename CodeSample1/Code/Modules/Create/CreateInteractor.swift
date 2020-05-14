//
//  CreateInteractor.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

class CreateInteractor: CreateInteractorProtocol {
    var view: CreateViewProtocol?
    var store: CreateStoreProtocol!
    var router: CreateRouterProtocol!
    
    func apply(string: String) {
        store.addNewItem(string)
        router.close()
    }
    
    func discard() {
        router.discardCreate()
    }
}
