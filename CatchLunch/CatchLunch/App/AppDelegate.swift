//
//  AppDelegate.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        if connectingSceneSession.role == .windowApplication {
            let config = UISceneConfiguration(
                name: "Default Configuration",
                sessionRole: connectingSceneSession.role
            )
            config.delegateClass = SceneDelegate.self
            return config
        }

        return UISceneConfiguration(
            name: nil,
            sessionRole: connectingSceneSession.role
        )
    }
}
