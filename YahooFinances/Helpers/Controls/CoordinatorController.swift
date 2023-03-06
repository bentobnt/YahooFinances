//
//  CoordinatorController.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

class CoordinatorController: UIViewController {
    // MARK: - Properties
    var appNavigationController: NavigationController?

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setupController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupController() {
        edgesForExtendedLayout = [.left, .right, .bottom]
        extendedLayoutIncludesOpaqueBars = true
    }
}
