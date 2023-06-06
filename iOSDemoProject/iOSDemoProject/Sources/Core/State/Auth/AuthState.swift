//
//  AuthState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation
import ReduxCore

enum AuthState: Equatable {
    case idle
    case email(AuthState.Email)
    
    struct EmailCredentials: Equatable, Codable {
        let email: String
        let password: String
    }
    
    struct EmailAuthorized: Equatable, Codable {
        let account: EmailAccount
        var remoteData: AuthTokenInfo
    }
    
    enum Email: Equatable {
        case signingIn(AuthState.EmailCredentials)
        case authorized(AuthState.EmailAuthorized)
        case signingInFailed(EmailAuthError)
        case loggingOut(AuthState.EmailAuthorized)
    }
}

func reduce(_ state: AuthState, with action: Action) -> AuthState {
    switch action {
    default:
        return state
    }
}
