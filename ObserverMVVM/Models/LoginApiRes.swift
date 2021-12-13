//
//  LoginApiRes.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

enum LoginStatus  {
    case success(token: String)
    case fail(message: String)
    
    func value() -> String {
        switch self {
        case .success(let token):
            return token
        case .fail(let message):
            return message
        }
    }
}

enum LoadingStatus {
    case loading
    case complete
}

