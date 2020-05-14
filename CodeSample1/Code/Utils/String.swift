//
//  String.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

extension String {
    var length: Int {
        return count
    }
    
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
}
