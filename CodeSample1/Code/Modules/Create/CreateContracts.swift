//
//  CreateContracts.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

enum CreateMode {
    case create, edit
}

protocol CreateViewProtocol: class {
    var interactor: CreateInteractorProtocol! { get set }

    func update(item: ListItemModel)
}

protocol CreateStoreProtocol {
    func addNewItem(string: String)
    func updateItem(id: Int, string: String, selected: Bool)
    func getItem(id: Int) -> ListItemModel?
}

protocol CreateInteractorProtocol {
    var view: CreateViewProtocol? { get set }
    var store: CreateStoreProtocol! { get set }
    
    func apply(string: String)
    func discard()
    func viewReady()
}

protocol CreateRouterProtocol {
    func close()
    func discardCreate()
}
