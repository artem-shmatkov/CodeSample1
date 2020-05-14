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
    func deleteItem(id: Int)
    func addNewItem(string: String)
    func itemChanged(id: Int, selected: Bool)
    func updateItem(id: Int, string: String, selected: Bool)
    
    func getItems() -> [ListItemModel]
    func getItem(id: Int) -> ListItemModel?
    
    func addListener(_ listener: BaseStoreListenerProtocol)
}

class BaseListStorage: NSObject, BaseListStorageProtocol {
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
    
    func addNewItem(string: String) {
        let lastId = UserDefaults.standard.integer(forKey: lastListItemId) + 1
        UserDefaults.standard.set(lastId, forKey: lastListItemId)
        
        if !realm.isInWriteTransaction {
            realm.beginWrite()
        }
        
        let item = RealmListItemModel()
        item.id = lastId
        item.name = string
        item.selected = false
        realm.add(item)
        
        try? realm.commitWrite()
        
        notifyAdded(item: item)
    }
    
    func updateItem(id: Int, string: String, selected: Bool) {
        if let item = findItem(id: id) {
            if !realm.isInWriteTransaction {
                realm.beginWrite()
            }
            
            item.name = string
            item.selected = selected
            
            try? realm.commitWrite()
            
            notifyChanged(item: item)
        }
    }
    
    func itemChanged(id: Int, selected: Bool) {
        if let item = findItem(id: id) {
            if !realm.isInWriteTransaction {
                realm.beginWrite()
            }
            
            item.selected = selected
            
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
            let model = ListItemModel()
            model.id = item.id
            model.name = item.name
            model.selected = item.selected
            result.append(model)
        }
        
        return result
    }
    
    fileprivate func setupFirstTimeAccess() {
        if !realm.isInWriteTransaction {
            realm.beginWrite()
        }
        
        for i in 0...9 {
            let item = RealmListItemModel()
            item.id = i
            item.name = "item #\(i)"
            item.selected = i % 2 == 0
            realm.add(item)
        }
        
        try? realm.commitWrite()
        
        UserDefaults.standard.set(9, forKey: lastListItemId)
    }
    
    func getItem(id: Int) -> ListItemModel? {
        if let item = findItem(id: id) {
            let model = ListItemModel()
            model.id = item.id
            model.name = item.name
            model.selected = item.selected
            return model
        }
        
        return nil
    }
    
    fileprivate func findItem(id: Int) -> RealmListItemModel? {
        let predicate = NSPredicate(format: "id == \(id)")
        let items = realm.objects(RealmListItemModel.self).filter(predicate)
        return items.first
    }
    
    fileprivate func notifyAdded(item: RealmListItemModel) {
        let model = ListItemModel()
        model.id = item.id
        model.name = item.name
        model.selected = item.selected
        
        listeners.forEach { $0.itemAdded(item: model) }
    }
    
    fileprivate func notifyChanged(item: RealmListItemModel) {
        let model = ListItemModel()
        model.id = item.id
        model.name = item.name
        model.selected = item.selected
        
        listeners.forEach { $0.itemChanged(item: model) }
    }
}
