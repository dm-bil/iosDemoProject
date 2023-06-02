//
//  SceneDelegate.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = .white
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

