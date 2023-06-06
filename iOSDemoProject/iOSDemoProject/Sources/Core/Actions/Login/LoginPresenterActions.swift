//
//  LoginPresenterActions.swift
//
//
//  Created by Serhii Onopriienko on 13.04.2021.
//

import ReduxCore
import Foundation

public extension Actions {
    enum LoginPresenter {
        public struct EmailDidChange: Action {
            public let email: String
            public init(email: String) {
                self.email = email
            }
        }
        
        public struct PasswordDidChange: Action {
            public let password: String
            
            public init(password: String) {
                self.password = password
            }
        }
        
        public struct SignIn: Action {
            public let email: String
            public let password: String
            
            public init(email: String, password: String) {
                self.email = email
                self.password = password
            }
        }
    }
}
