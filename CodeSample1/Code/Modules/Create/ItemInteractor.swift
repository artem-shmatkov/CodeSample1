//
//  ItemInteractor.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

class ItemInteractor: ItemInteractorProtocol {
    weak var view: ItemViewProtocol?
    var store: ItemStoreProtocol!
    var router: ItemRouterProtocol!
    
    var idToEdit: Int = -1
    var activeItem: ListItemModel?
    
    func viewReady() {
        if let item = store.getItem(id: idToEdit) {
            activeItem = item
            view?.update(item: item)
        }
    }
    
    func apply(string: String) {
        if let item = activeItem {
            store.updateItem(id: item.id, string: string, selected: item.selected)
        } else {
            store.addItem(string: string)
        }
        router.close()
    }
    
    func discard() {
        router.close()
    }
}
