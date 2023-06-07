//
//  EmailSignInPresenter.swift
//  Betterme
//
//  Created Serhii Onopriienko on 19.03.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import ReduxCore
import BMCommand
import Foundation

struct EmailSignInPresenter {
    let render: CommandWith<EmailSignInController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(with: EmailSignInController.Props(state: makePropsState(from: state), onDestroy: endObserving))
    }
    
    private func makePropsState(from state: AppState) -> EmailSignInController.Props.State {
        guard
            case .email(.signingIn(let credentials)) = state.auth
        else { return .idle }
        
        let requestData = EmailSignInController.Props.RequestData(
            email: credentials.email,
            password: credentials.password
        )
        
        return .signIn(
            data: requestData,
            onSuccess: CommandWith(id: "onSuccess") { response in
                let action = Actions.EmailSignInPresenter.Succeeded(
                    authTokenInfo: response.auth,
                    emailAccount: response.emailAccount
                )
                dispatch.perform(with: action)
            },
            onFailure: CommandWith(id: "onFailure") { error in
                let emailAuthError: EmailAuthError
                switch error {
                case EmailSignInError.credentialInvalid:
                    emailAuthError = .credentialInvalid
                default:
                    emailAuthError = .general(error.localizedDescription)
                }
                let action = Actions.EmailSignInPresenter.Failed(error: emailAuthError)
                dispatch.perform(with: action)
            }
        )
    }
}
