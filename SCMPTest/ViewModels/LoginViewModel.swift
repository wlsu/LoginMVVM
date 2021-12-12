//
//  LoginViewModel.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

class LoginViewModel {
    var alertContent: Observable<(title: String?, message: String?)>  = Observable(value: (title: "", message: ""))
    var apiResult = Observable(value: LoginStatus.fail(message: "failed"))
    var loadingStatus = Observable(value: LoadingStatus.complete)
    
    
    func loginRequest(email: String?, password: String?) {
        
        guard let email = email, email.count > 0 else {
            alertContent.value = (title: "Please input email", message: nil)
            return
        }
        
        guard let password = password, password.count > 0 else {
            alertContent.value = (title: "Please input password", message: nil)
            return
        }
        
        loadingStatus.value = .loading

        ApiService.loginApiRequest(email: email, password: password) { (res) in
 
            self.loadingStatus.value = .complete
            guard let theRes = res else {
                self.alertContent.value = (title: "Unknow error", message: "Please try again later")
                return
            }
            
            self.apiResult.value = theRes
            
        }
    }
    
    
}
