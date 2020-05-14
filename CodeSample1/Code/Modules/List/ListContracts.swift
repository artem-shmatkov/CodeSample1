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
    func update(element: ListItemModel)
}

protocol ListStoreProtocol {
    
}

protocol ListInteractorProtocol {
    var view: ListViewProtocol? { get set }
    var store: ListStoreProtocol! { get set }
    
    func viewReady()
    
    func addButtonTouched()
    func editElement(id: Int)
    func deleteElement(id: Int)
}

protocol ListRouterProtocol {
    func wantAddElement()
    func wantEditElement(id: Int)
}
