//
//  Sugar.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

func delay(_ delay: Double, _ closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func asyncMain(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async {
        closure()
    }
}

func asyncBack(_ closure: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
        closure()
    }
}

func loadImage(_ name: String) -> UIImage? {
    return UIImage(named: name)
}
