//
//  AppDelegate.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var mainCoordinator: MainCoordinator?
    var window: UIWindow?

    // MARK: - App delegate methods
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FlutterManager.sharedInstance.configure()
        start()
        return true
    }

    // MARK: - Private methods
    private func start() {
        mainCoordinator = MainCoordinator()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }

}

