//
//  NavigationMiddleware.swift
//  BetterMen
//
//  Created by Vadym Mitin on 16.02.2023.
//  Copyright © 2023 Genesis Media. All rights reserved.
//

import ReduxCore
import Foundation
import BMCommand

final class NavigationMiddleware {
    func middleware() -> Middleware<AppState> {
        { (dispatch: @escaping Dispatch, action: Action, oldState: AppState, newState: AppState) in
            switch action {
            case is Actions.Application.DidFinishLaunch:
                switch newState.auth {
                case .idle:
                    dispatch(Actions.NavigationMiddlewareActions.ShowLogin())
                case .email:
                    dispatch(Actions.NavigationMiddlewareActions.ShowMain())
                }
                
            default:
                break
            }
        }
    }
}
