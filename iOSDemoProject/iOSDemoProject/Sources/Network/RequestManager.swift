//
//  RequestManager.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

protocol RequestManager {
    func v5EmailSingInPost(email: String, password: String) -> Request<EmailSignInResponse>
}
