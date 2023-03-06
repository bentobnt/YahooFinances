//
//  NavigationController.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

class NavigationController: UINavigationController {
    // MARK: - View methods
    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBackButton()
    }

    // MARK: - Private methods
    private func setupBackButton() {
        let textAttributes = [NSAttributedString.Key.font: UIFont.primaryBold(ofSize: .extraLarge),
                              NSAttributedString.Key.foregroundColor: UIColor.appPrimaryColor]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
                                                                   style: .plain,
                                                                   target: nil,
                                                                   action: nil)
        navigationBar.tintColor = .appPrimaryColor
    }
}
