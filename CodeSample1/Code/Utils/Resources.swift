//
//  Resources.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation
import UIKit

postfix operator §

extension String {
    static postfix func § (string: String) -> String {
        return string.localized
    }
}

enum ui {
    enum string {
        enum common {
            static var empty: String { return "" }
            static var error: String { return "ui.string.common.error"§ }
            static var add: String { return "ui.string.common.add"§ }
            static var list: String { return "ui.string.common.list"§ }
            static var service: String { return "ui.string.common.service"§ }
        }
    }

    enum image {
        enum tabbar {
            enum list {
                static var normal: UIImage! { return loadImage("img-tab-list-icon"§) }
                static var selected: UIImage! { return loadImage("img-tab-list-icon-selected"§) }
            }

            enum service {
                static var normal: UIImage! { return loadImage("img-tab-service-icon"§) }
                static var selected: UIImage! { return loadImage("img-tab-service-icon-selected"§) }
            }
        }
    }

    enum font {
        enum sf {
            case ultraLight
            case thin
            case light
            case regular
            case medium
            case semibold
            case bold
            case black
            case heavy
            case heavyItalic

            func size(_ size: CGFloat) -> UIFont {
                var weight: UIFont.Weight = .regular

                switch self {
                case .ultraLight: weight = .ultraLight
                case .thin: weight = .thin
                case .light: weight = .light
                case .regular: weight = .regular
                case .medium: weight = .medium
                case .semibold: weight = .semibold
                case .bold: weight = .bold
                case .black: weight = .black
                case .heavy: weight = .heavy
                default: weight = .regular
                }

                return UIFont.systemFont(ofSize: size, weight: weight)
            }
        }
    }

    enum color {
        static var white: UIColor { return UIColor.white }
        static var clear: UIColor { return UIColor.clear }
        static var black: UIColor { return UIColor.black }
        static var dark12: UIColor { return UIColor(red: 44.0 / 255.0, green: 40.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.12) }
        static var apple: UIColor { return UIColor(red: 122.0 / 255.0, green: 201.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0) }
        static var orchid: UIColor { return UIColor(red: 189.0 / 255.0, green: 104.0 / 255.0, blue: 198.0 / 255.0, alpha: 1.0) }
        static var warmPink: UIColor { return UIColor(red: 247.0 / 255.0, green: 89.0 / 255.0, blue: 105.0 / 255.0, alpha: 1.0) }
        static var darkPink: UIColor { return UIColor(red: 255.0 / 255.0, green: 66.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0) }
        static var yellowish: UIColor { return UIColor(red: 255.0 / 255.0, green: 205.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0) }
        static var orangeish: UIColor { return UIColor(red: 255.0 / 255.0, green: 143.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0) }
        static var paleGrey: UIColor { return UIColor(red: 242.0 / 255.0, green: 243.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0) }
        static var darkGrey: UIColor { return UIColor(red: 231.0 / 255.0, green: 232.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0) }
        static var charcoalGrey: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0) }
        static var lightIndigo: UIColor { return UIColor(red: 119.0 / 255.0, green: 78.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0) }
        static var charcoalGrey8: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.08) }
        static var charcoalGrey40: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.4) }
        static var charcoalGrey30: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.3) }
        static var charcoalGrey60: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.6) }
        static var charcoalGrey12: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.12) }
        static var charcoalGrey85: UIColor { return UIColor(red: 40.0 / 255.0, green: 43.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.85) }
    }
}
