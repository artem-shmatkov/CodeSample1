//
//  ServiceContracts.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

protocol ServiceViewProtocol: class {
    var interactor: ServiceInteractorProtocol! { get set }
}

protocol ServiceStoreProtocol {
    
}

protocol ServiceInteractorProtocol {
    var view: ServiceViewProtocol? { get set }
    var store: ServiceStoreProtocol! { get set }
}

protocol ServiceCoordinatorProtocol {
    
}
