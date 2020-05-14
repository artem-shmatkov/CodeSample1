//
//  ServiceContracts.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

enum ServiceViewState {
    case loading, ready
}

protocol ServiceViewProtocol: class {
    var interactor: ServiceInteractorProtocol! { get set }
    
    func showList(_ list: [ServiceItemModel])
    func showError(_ error: Error?)
}

protocol ServiceStoreProtocol {
    func update(completion: @escaping ServiceUpdateCompletion)
}

protocol ServiceInteractorProtocol {
    var view: ServiceViewProtocol? { get set }
    var store: ServiceStoreProtocol! { get set }
    
    func viewReady()
}

protocol ServiceRouterProtocol {
    
}
