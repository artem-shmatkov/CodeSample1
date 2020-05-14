//
//  ListContracts.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

protocol ListViewProtocol: class {
    var interactor: ListInteractorProtocol! { get set }
    
    func update(array: [ListItemModel])
    func update(item: ListItemModel)
}

protocol ListStoreProtocol {
    var listener: ListStoreListenerProtocol! { get set }
    
    func setup()
    func deleteItem(id: Int)
    func getItems() -> [ListItemModel]
    func itemChanged(id: Int, selected: Bool)
}

protocol ListInteractorProtocol {
    var view: ListViewProtocol? { get set }
    var store: ListStoreProtocol! { get set }
    
    func viewReady()
    
    func addButtonTouched()
    func editItem(id: Int)
    func deleteItem(id: Int)
    func itemChanged(id: Int, selected: Bool)
}

protocol ListRouterProtocol {
    func wantAddItem()
    func wantEditItem(id: Int)
}
