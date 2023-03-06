//
//  UITableViewCell+Extensions.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 03/03/23.
//

import UIKit

extension UITableViewCell {

    // MARK: - Public class methods
    class func uid() -> String {
        return String(describing: self);
    }
}
