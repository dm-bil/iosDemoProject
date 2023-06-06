//
//  AppDelegate.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import UIKit
import ReduxCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var coordinator = AppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        defer {
            StoreLocator.shared.dispatch(action: Actions.Application.DidFinishLaunch(launchOptions: launchOptions?.description))
        }
        configureWindow()
        configureStore()
        return true
    }

    private func configureStore() {
        let store = Store(
            state: AppState.initial,
            reducer: reduce,
            middlewares: [
                CoordinatorMiddleware(handler: coordinator.handle).middleware(),
                NavigationMiddleware().middleware(),
            ]
        )
        StoreLocator.populate(with: store)
    }
    
    private func configureWindow() {
        window = coordinator.window
    }
}

