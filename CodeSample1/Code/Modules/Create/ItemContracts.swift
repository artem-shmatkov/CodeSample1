//
//  ItemContracts.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

protocol ItemViewProtocol: class {
    var interactor: ItemInteractorProtocol! { get set }

    func update(item: ListItemModel)
}

protocol ItemStoreProtocol {
    func addItem(string: String)
    func updateItem(id: Int, string: String, selected: Bool)
    func getItem(id: Int) -> ListItemModel?
}

protocol ItemInteractorProtocol: BaseInteractorProtocol {
    var view: ItemViewProtocol? { get set }
    var store: ItemStoreProtocol! { get set }
    
    func apply(string: String)
    func discard()
}

protocol ItemRouterProtocol {
    func close()
}
