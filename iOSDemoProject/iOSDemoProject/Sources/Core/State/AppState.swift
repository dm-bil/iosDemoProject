//
//  AppState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation
import ReduxCore

struct AppState: Equatable {
    let auth: AuthState
    let emailAuthInput: EmailAuthInputState?
    
    static let initial = AppState(
        auth: .idle,
        emailAuthInput: nil
    )
}

func reduce(_ state: AppState, with action: Action) -> AppState {
    AppState(
        auth: reduce(state.auth, with: action),
        emailAuthInput: reduce(state.emailAuthInput, with: action)
    )
}
