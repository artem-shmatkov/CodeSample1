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
}

protocol CreateStoreProtocol {
    func addNewItem(_ string: String)
}

protocol CreateInteractorProtocol {
    var view: CreateViewProtocol? { get set }
    var store: CreateStoreProtocol! { get set }
    
    func apply(string: String)
    func discard()
}

protocol CreateRouterProtocol {
    func close()
    func discardCreate()
}
