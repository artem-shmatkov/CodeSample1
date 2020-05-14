//
//  ListContracts.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

protocol ListViewProtocol: class {
    var interactor: ListInteractorProtocol! { get set }
}

protocol ListStoreProtocol {
    
}

protocol ListInteractorProtocol {
    var view: ListViewProtocol? { get set }
    var store: ListStoreProtocol! { get set }
}

protocol ListCoordinatorProtocol {
    
}
