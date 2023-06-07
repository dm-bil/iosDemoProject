//
//  MainCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import ReduxCore

final class MainCoordinator: ChainCoordinator {
    var rootViewController: UIViewController {
        tabController
    }

    private let tabController: UITabBarController
    
    var next: ChainCoordinator?
    
    private let profileCoordinator = ProfileCoordinator()
    private let listCoordinator = ListCoordinator()
    
    init() {
        self.tabController = UITabBarController()
        self.tabController.viewControllers = [
            listCoordinator.rootViewController,
            profileCoordinator.rootViewController
        ]
    }
    
    func handle(state: AppState, action: Action) -> Bool {
        if next?.handle(state: state, action: action) == true {
            return true
        }
        
        switch action {
        
        default:
            return false
        }
    }
}
