//
//  MainCoordinator.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit
import Flutter

class MainCoordinator: CoordinatorController {
    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }

    // MARK: - Private methods
    private func start() {
        let homeService = HomeService()
        let viewController = HomeViewController(viewModel: HomeViewModel(service: homeService))
        viewController.coordinator = self

        appNavigationController = NavigationController(rootViewController: viewController)
        install(appNavigationController!)
    }

    // MARK: - Public methods
    func pushFlutterDetailsController(data: [[String: Any]]) {
        let flutterController = FlutterManager.sharedInstance.createFlutterViewController()
        FlutterManager.sharedInstance.invokeMethodSendDataToFlutter(json: data)
        appNavigationController?.present(flutterController, animated: true)
    }

    func presentError(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self?.appNavigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
