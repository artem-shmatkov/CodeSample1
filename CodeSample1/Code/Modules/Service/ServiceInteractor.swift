//
//  ServiceInteractor.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

class ServiceInteractor: ServiceInteractorProtocol {
    var view: ServiceViewProtocol?
    var store: ServiceStoreProtocol!
}
