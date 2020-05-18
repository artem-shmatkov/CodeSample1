//
//  BaseListStorage.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation
import RealmSwift

fileprivate let lastListItemId = "lastListItemId"
fileprivate let setFirstTimeItems = "setFirstTimeItems"

protocol BaseStoreListenerProtocol {
    func itemAdded(item: ListItemModel)
    func itemChanged(item: ListItemModel)
}

protocol BaseListStorageProtocol {
    func addItem(string: String)
    func deleteItem(id: Int)
    func updateItem(id: Int, string: String?, selected: Bool?)
    
    func getItems() -> [ListItemModel]
    func getItem(id: Int) -> ListItemModel?
    
    func addListener(_ listener: BaseStoreListenerProtocol)
}

class BaseListStorage: BaseListStorageProtocol {
    static let shared = BaseListStorage()
    
    fileprivate var realm: Realm!
    fileprivate var listeners: [BaseStoreListenerProtocol] = []
    
    func setup() {
        if let r = try? Realm() {
            realm = r
        } else {
            print("Не удалось активировать Realm")
        }
    }
    
    func addListener(_ listener: BaseStoreListenerProtocol) {
        listeners.append(listener)
    }
    
    func addItem(string: String) {
        let lastId = UserDefaults.standard.integer(forKey: lastListItemId) + 1
        UserDefaults.standard.set(lastId, forKey: lastListItemId)
        
        if !realm.isInWriteTransaction {
            realm.beginWrite()
        }
        
        let item = objectFrom(id: lastId, name: string, selected: false)
        realm.add(item)
        
        try? realm.commitWrite()
        
        notifyAdded(item: item)
    }
    
    func updateItem(id: Int, string: String? = nil, selected: Bool? = nil) {
        if let item = findItem(id: id) {
            if !realm.isInWriteTransaction {
                realm.beginWrite()
            }
            
            item.name = string ?? item.name
            item.selected = selected ?? item.selected
            
            try? realm.commitWrite()
            
            notifyChanged(item: item)
        }
    }
    
    func deleteItem(id: Int) {
        if let item = findItem(id: id) {
            if !realm.isInWriteTransaction {
                realm.beginWrite()
            }
            
            realm.delete(item)
            
            try? realm.commitWrite()
        }
    }
    
    func getItems() -> [ListItemModel] {
        let firstTimeItems = UserDefaults.standard.bool(forKey: setFirstTimeItems)
        if !firstTimeItems {
            setupFirstTimeAccess()
            UserDefaults.standard.set(true, forKey: setFirstTimeItems)
        }
        
        var result: [ListItemModel] = []
        let items = realm.objects(RealmListItemModel.self)
        for item in items {
            let model = modelFrom(item: item)
            result.append(model)
        }
        
        return result
    }
    
    func getItem(id: Int) -> ListItemModel? {
        if let item = findItem(id: id) {
            return modelFrom(item: item)
        }
        
        return nil
    }
    
    fileprivate func setupFirstTimeAccess() {
        if !realm.isInWriteTransaction {
            realm.beginWrite()
        }
        
        for i in 0...9 {
            let item = objectFrom(id: i, name: "item #\(i)", selected: i % 2 == 0)
            realm.add(item)
        }
        
        try? realm.commitWrite()
        
        UserDefaults.standard.set(9, forKey: lastListItemId)
    }
    
    fileprivate func objectFrom(id: Int, name: String, selected: Bool) -> RealmListItemModel {
        let item = RealmListItemModel()
        item.id = id
        item.name = name
        item.selected = selected
        return item
    }
    
    fileprivate func modelFrom(item: RealmListItemModel) -> ListItemModel {
        let model = ListItemModel(id: item.id,
                                  name: item.name,
                                  selected: item.selected)
        return model
    }
    
    fileprivate func findItem(id: Int) -> RealmListItemModel? {
        let predicate = NSPredicate(format: "id == \(id)")
        let items = realm.objects(RealmListItemModel.self).filter(predicate)
        return items.first
    }
    
    fileprivate func notifyAdded(item: RealmListItemModel) {
        let model = modelFrom(item: item)
        listeners.forEach { $0.itemAdded(item: model) }
    }
    
    fileprivate func notifyChanged(item: RealmListItemModel) {
        let model = modelFrom(item: item)
        listeners.forEach { $0.itemChanged(item: model) }
    }
}
