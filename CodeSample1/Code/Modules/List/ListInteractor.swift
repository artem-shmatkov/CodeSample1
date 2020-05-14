//
//  ListInteractor.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

class ListInteractor: ListInteractorProtocol {
    var view: ListViewProtocol?
    var store: ListStoreProtocol!
    var router: ListRouterProtocol!
    
    func viewReady() {
        setupData()
    }
    
    fileprivate func setupData() {
        var array: [ListItemModel] = []
        
        for i in 0...9 {
            let item = ListItemModel()
            item.name = "item #\(i)"
            item.selected = i % 2 == 0
            array.append(item)
        }
        
        view?.update(array: array)
    }
    
    // MARK: ListInteractorProtocol
    
    @objc func addButtonTouched() {
        router.wantAddElement()
    }
    
    func editElement(id: Int) {
        router.wantEditElement(id: id)
    }
    
    func deleteElement(id: Int) {
//        store.delete
    }
}
