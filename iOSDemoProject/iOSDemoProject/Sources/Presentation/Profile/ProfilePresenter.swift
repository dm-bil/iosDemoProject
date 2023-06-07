//
//  ProfilePresenter.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation
import BMCommand
import ReduxCore

struct ProfilePresenter {
    private typealias Props = ProfileViewController.Props
    
    let render: CommandWith<ProfileViewController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(
            with: Props(
                onDestroy: endObserving
            )
        )
    }
}
