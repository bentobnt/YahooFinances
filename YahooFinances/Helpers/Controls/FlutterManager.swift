//
//  FlutterManager.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 03/03/23.
//

import Foundation
import Flutter
import FlutterPluginRegistrant

class FlutterManager {
    // MARK: - Struct
    struct K {
        static let flutterEngine = "flutter_engine"
        static let flutterChannel = "flutter_channel"
    }

    // MARK: - Shared instance
    public static let sharedInstance = FlutterManager()

    // MARK: - Properties
    var flutterEngine: FlutterEngine?
    var methodChannel: FlutterMethodChannel?

    private var controller = UIViewController()

    // MARK: - Public methods
    func configure() {
        flutterEngine = FlutterEngine(name: K.flutterEngine, project: nil)
        guard let flutterEngine = flutterEngine else { return }
        flutterEngine.run(withEntrypoint: nil)
        GeneratedPluginRegistrant.register(with: flutterEngine)
        methodChannel = FlutterMethodChannel(name: K.flutterChannel,
                                             binaryMessenger: flutterEngine.binaryMessenger)
        setupFlutterListener()
    }

    func createFlutterViewController() -> UIViewController {
        guard let flutterEngine = flutterEngine else { return FlutterViewController() }
        controller = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        return controller
    }
 }

// MARK: - Listener methods
private extension FlutterManager {
    func setupFlutterListener() {
        methodChannel?.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else { return }
            switch call.method {
            case "close_flutter":
                self.controller.dismiss(animated: true)
                result(true)
            default:
                print("Unrecognized method name: \(call.method)")
            }
        })
    }
}

// MARK: - Emiter methods
extension FlutterManager {
    // MARK: - Public methods
    func invokeMethodSendDataToFlutter(json: [[String: Any]]) {
        methodChannel?.invokeMethod("getNativeData", arguments: json)
    }
}

