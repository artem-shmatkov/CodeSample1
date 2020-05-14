//
//  CreateStore.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

class CreateStore: CreateStoreProtocol {
    var baseStorage: BaseListStorageProtocol!
    
    func addNewItem(string: String) {
        baseStorage.addNewItem(string: string)
    }
    
    func updateItem(id: Int, string: String, selected: Bool) {
        baseStorage.updateItem(id: id, string: string, selected: selected)
    }
    
    func getItem(id: Int) -> ListItemModel? {
        baseStorage.getItem(id: id)
    }
}
