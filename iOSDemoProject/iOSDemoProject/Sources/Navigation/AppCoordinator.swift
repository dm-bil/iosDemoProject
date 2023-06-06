//
//  AppCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import UIKit
import ReduxCore

final class AppCoordinator: ChainCoordinator {
    let window: UIWindow
    
    var rootViewController: UIViewController {
        containerController
    }
    
    private let containerController = ContainerViewController()
    
    var next: ChainCoordinator?
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        configure()
    }
    
    private func configure() {
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        window.rootViewController = containerController
        containerController.displayContentController(AppLaunchViewController())
    }
    
    func handle(state: AppState, action: Action) -> Bool {
        if next?.handle(state: state, action: action) == true {
            return true
        }
        
        switch action {
        case is Actions.NavigationMiddlewareActions.ShowLogin:
            let vc = LoginScreenFactory().default()
            containerController.displayContentController(vc)
            return true
            
        default:
            return false
        }
    }
}
