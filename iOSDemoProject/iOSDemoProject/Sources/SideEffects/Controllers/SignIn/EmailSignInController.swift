//
//  EmailSignInControllerViewController.swift
//  Betterme
//
//  Created Serhii Onopriienko on 19.03.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import BMCommand
import Foundation

enum EmailSignInError: CustomNSError {
    case credentialInvalid
}

public final class EmailSignInController: NSObject {
    struct Props: Equatable {
        enum State: Equatable {
            case idle
            case signIn(data: RequestData, onSuccess: CommandWith<ResponseData>, onFailure: CommandWith<Error>)
        }
        
        struct RequestData: Equatable {
            let email: String
            let password: String
        }
        
        struct ResponseData: Equatable {
            let emailAccount: EmailAccount
            let auth: AuthTokenInfo
            let userProperties: UserProperties
        }
        
        enum ResponseError: Error {
            case missingUserProps
        }
        
        let state: State
        let onDestroy: Command
        static let initial = EmailSignInController.Props(state: .idle, onDestroy: .nop)
    }
    
    private let requestManager: RequestManager
    private var props: EmailSignInController.Props = .initial
    private var cancel: Command?
    
    deinit {
        props.onDestroy.perform()
    }
    
    init(
        requestManager: RequestManager
    ) {
        self.requestManager = requestManager
    }
    
    func render(props: EmailSignInController.Props) {
        guard self.props != props else { return }
        
        cancel?.perform()
        cancel = nil
        self.props = props
        
        switch props.state {
        case .idle:
            break
        case let .signIn(data, onSuccess, onFailure):
            signIn(data: data, onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    // MARK: Sign in
    
    private func signIn(data: EmailSignInController.Props.RequestData, onSuccess: CommandWith<EmailSignInController.Props.ResponseData>, onFailure: CommandWith<Error>) {
        cancel = requestManager.v5EmailSingInPost(
            email: data.email,
            password: data.password
        ).perform { result in
            switch result {
            case .success(let response):
                let responseData = EmailSignInController.Props.ResponseData(
                    emailAccount: EmailAccount(
                        email: response.emailAccount.email,
                        confirmed: response.emailAccount.confirmed
                    ),
                    auth: AuthTokenInfo(
                        accessToken: response.auth.accessToken,
                        expiresInTimestamp: response.auth.expiresInTimestamp,
                        tokenType: response.auth.tokenType,
                        refreshToken: response.auth.refreshToken
                    ),
                    userProperties: UserProperties(
                        fullName: response.userProperties.fullName,
                        avatarUrl: response.userProperties.avatarUrl,
                        dateOfBirth: response.userProperties.dateOfBirth,
                        about: response.userProperties.about
                    )
                )
                
                onSuccess.perform(with: responseData)
                
//            case .failure(ApiServiceError.cancelled):
//                break
//                
//            case .failure(ApiServiceError.httpError(let code, _, _)) where code == 404:
//                onFailure.perform(with: EmailSignInError.credentialInvalid)
//                
            case .failure(let error):
                onFailure.perform(with: error)
            }
        }
    }
}
