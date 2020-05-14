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
    
    fileprivate var startDate: Date!
    
    func viewReady() {
        startDate = Date()
        
        store.update { [weak self] (data, error) in
            self?.checkDelay(data, error: error)
        }
    }
    
    func checkDelay(_ data: [DiskData]?, error: Error?) {
        // NOTE: Делаем задержку некоторое время принудительно, чтобы не было мельканий лоадера
        let loaderTime: Double = 3
        let endDate = Date()
        let interval = endDate.timeIntervalSince(startDate)
        if interval < loaderTime {
            delay(loaderTime - interval) { [weak self] in
                self?.processData(data, error: error)
            }
        } else {
            processData(data, error: error)
        }
    }
    
    func processData(_ data: [DiskData]?, error: Error?) {
        if let data = data {
            let converted = convertData(data)
            view?.showList(converted)
        } else if let error = error {
            view?.showError(error)
        }
    }
    
    func convertData(_ data: [DiskData]) -> [ServiceItemModel] {
        var result: [ServiceItemModel] = []
        for disk in data {
            let model = ServiceItemModel()
            model.title = disk.title
            model.artist = disk.artist
            model.country = disk.country
            model.company = disk.company
            model.price = disk.price
            model.year = disk.year
            result.append(model)
        }
        return result
    }
}
