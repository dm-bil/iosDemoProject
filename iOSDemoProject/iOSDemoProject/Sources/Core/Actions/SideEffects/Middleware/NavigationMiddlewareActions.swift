//
//  NavigationMiddlewareActions.swift
//  
//
//  Created by Vadym Mitin on 16.02.2023.
//

import ReduxCore
import Foundation

public extension Actions {
    enum NavigationMiddleware {
        public struct ShowLogin: Action {
            public init() {}
        }
        
        public struct ShowMain: Action {
            public init() {}
        }
    }
}
