//
//  ListInteractor.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

class ListInteractor: ListInteractorProtocol, ListStoreListenerProtocol {
    var view: ListViewProtocol?
    var store: ListStoreProtocol!
    var router: ListRouterProtocol!
    
    func viewReady() {
        store.setup()
        setupData()
    }
    
    fileprivate func setupData() {
        store.listener = self
        
        let array = store.getItems()
        view?.update(array: array)
    }
    
    // MARK: ListInteractorProtocol
    
    @objc func addButtonTouched() {
        router.wantAddItem()
    }
    
    func editItem(id: Int) {
        router.wantEditItem(id: id)
    }
    
    func deleteItem(id: Int) {
        store.deleteItem(id: id)
    }
    
    func itemChanged(id: Int, selected: Bool) {
        store.itemChanged(id: id, selected: selected)
    }
    
    // MARK: ListStoreListenerProtocol
    
    func itemAdded(item: ListItemModel) {
        view?.update(item: item)
    }
    
    func itemChanged(item: ListItemModel) {
        view?.update(item: item)
    }
}
