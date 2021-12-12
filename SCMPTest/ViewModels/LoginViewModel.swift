//
//  LoginViewModel.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

struct LoginViewState {
    static var loadingStatus = Observable(value: LoadingStatus.complete)
}

class LoginViewModel {
    
    func loginRequest(email: String?, password: String?, failedHandler: @escaping ( ( (title: String?, message: String?)? ) -> Void),  successHanler: @escaping (LoginStatus) -> Void) {
        
        guard let email = email, email.count > 0 else {
            failedHandler( (title: "Please input email", message: nil) )
            return
        }
        
        guard let password = password, password.count > 0 else {
            failedHandler( (title: "Please input password", message: nil) )
            return
        }
        
        LoginViewState.loadingStatus.value = .loading

        ApiService.loginApiRequest(email: email, password: password) { (res) in
 
            LoginViewState.loadingStatus.value = .complete
            guard let theRes = res else {
                failedHandler( (title: "Unknow error", message: "Please try again later") )
                return
            }
            
            successHanler(theRes)
            
        }
    }
    
    
}
