//
//  SceneDelegate.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let indicator = UIActivityIndicatorView(style: .medium)
    private var coordinator: Coordiantorable?
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setUpWindowAndRootCoordinator(with: windowScene)
        setUpIndicator()
        addNotificationObservers()
    }

    private func setUpWindowAndRootCoordinator(with windowScene: UIWindowScene) {
        let navigationController = UINavigationController()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        coordinator = RootCoordinator(on: navigationController)
        coordinator?.start()
    }
}

// MARK: - Notfication
extension SceneDelegate {
    private func addNotificationObservers() {
        addObserver(about: .startNetwokring, with: #selector(showIndicator))
        addObserver(about: .finishNetworking, with: #selector(hideIndicator))
        addObserver(
            about: .finishNetworkingOnError,
            with: #selector(hideIndicatorAndShowAlert(_:))
        )
    }

    private func addObserver(about name: Notification.Name, with selector: Selector) {
        NotificationCenter
            .default
            .addObserver(self, selector: selector, name: name, object: nil)
    }
}

// MARK: - Alert and Indicator
extension SceneDelegate {
    @objc func showIndicator() {
        guard let window = window else { return }
        DispatchQueue.main.async { [weak self] in
            self?.indicator.center = window.center
            self?.indicator.startAnimating()
        }
    }

    @objc func hideIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.indicator.stopAnimating()
        }
    }

    @objc func hideIndicatorAndShowAlert(_ notification: NSNotification) {
        hideIndicator()
        guard let userInfo = notification.userInfo else {
            return
        }
        let message = userInfo["message"] as? String
        showAlert(with: message)
    }

    private func setUpIndicator() {
        let basicMargin: CGFloat = -8.0
        indicator.backgroundColor = .darkGray
        indicator.color = .white
        indicator.frame = indicator.frame.insetBy(dx: basicMargin, dy: basicMargin)
        indicator.layer.cornerRadius = .pi
        window?.addSubview(indicator)
    }

    private func showAlert(with message: String?) {
        let alertController = UIAlertController(title: "주의", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            self?.window?.rootViewController?.present(alertController, animated: true)
        }
    }
}
