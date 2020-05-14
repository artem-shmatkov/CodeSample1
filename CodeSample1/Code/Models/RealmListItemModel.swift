//
//  RealmListItemModel.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation
import RealmSwift

@objcMembers class RealmListItemModel: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var selected = false
}
