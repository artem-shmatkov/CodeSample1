//
//  ListStore.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

protocol ListStoreListenerProtocol {
    func itemAdded(item: ListItemModel)
    func itemChanged(item: ListItemModel)
}

class ListStore: ListStoreProtocol, BaseStoreListenerProtocol {
    var baseStorage: BaseListStorageProtocol!
    var listener: ListStoreListenerProtocol!
    
    func setup() {
        baseStorage.addListener(self)
    }
    
    func deleteItem(id: Int) {
        baseStorage.deleteItem(id: id)
    }
    
    func itemChanged(id: Int, selected: Bool) {
        baseStorage.updateItem(id: id, string: nil, selected: selected)
    }
    
    func getItems() -> [ListItemModel] {
        return baseStorage.getItems()
    }
    
    func addListener(_ listener: BaseStoreListenerProtocol) {
        baseStorage.addListener(self)
    }
    
    // MARK: BaseStoreListenerProtocol
    
    func itemAdded(item: ListItemModel) {
        listener.itemAdded(item: item)
    }
    
    func itemChanged(item: ListItemModel) {
        listener.itemChanged(item: item)
    }
}
