//
//  LoginApiRes.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

struct LoginApiRes {
    var token: String?
    var errorMessage: String?
    
    init(parameters: [String:Any]) {
        if let token = parameters["token"] as? String {
            self.token = token
        }
        
        if let errorMessage = parameters["error"] as? String  {
            self.errorMessage = errorMessage
        }
    }
}
