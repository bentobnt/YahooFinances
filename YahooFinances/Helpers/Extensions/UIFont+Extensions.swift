//
//  UIFont+Extensions.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

extension UIFont {
    private struct Font {
        static let regular = "HelveticaNeue"
        static let medium = "HelveticaNeue-Medium"
        static let bold = "HelveticaNeue-Bold"
    }

    class func primary(ofSize size: FontSize) -> UIFont {
        guard let font =  UIFont(name: Font.regular, size: size.value) else {
            return .systemFont(ofSize: size.value)
        }
        return font
    }

    class func primaryBold(ofSize size: FontSize) -> UIFont {
        guard let font = UIFont(name: Font.medium, size: size.value) else {
            return .boldSystemFont(ofSize: size.value)
        }
        return font
    }

    class func primaryExtraBold(ofSize size: FontSize) -> UIFont {
        guard let font = UIFont(name: Font.bold, size: size.value) else {
            return .boldSystemFont(ofSize: size.value)
        }
        return font
    }
}

enum FontSize {
    case custom(CGFloat)
    case small
    case regular
    case large
    case extraLarge
    case big

    var value: CGFloat {
        switch self {
        case .custom(let value):
            return value
        case .small:
            return 10
        case .regular:
            return 12
        case .large:
            return 16
        case .extraLarge:
            return 20
        case .big:
            return 24
        }
    }
}

