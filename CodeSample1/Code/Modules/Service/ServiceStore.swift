//
//  ServiceStore.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

typealias ServiceUpdateCompletion = (_ result: [DiskData]?, _ error: Error?) -> Void

class ServiceStore: ServiceStoreProtocol {
    fileprivate let loader = Loader.shared
    
    func update(completion: @escaping ServiceUpdateCompletion) {
        loader.load { [weak self] (data, error) in
            if let data = data {
                self?.parseData(data: data, completion: completion)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    func parseData(data: Data, completion: @escaping ServiceUpdateCompletion) {
        let parser = Parser()
        parser.parse(data: data) { (disks, error) in
            completion(disks, error)
        }
    }
}
