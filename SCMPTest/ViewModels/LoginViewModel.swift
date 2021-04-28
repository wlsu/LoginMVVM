//
//  LoginViewModel.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

protocol LoginViewModelProtocol {
    func loginComplete()
    func promptAlert(title: String?, message: String?)
}

class LoginViewModel {
    // User shared as this ViewModel will be used in diffrent Views' instance
    static var shared = LoginViewModel()
    
    var delegate: LoginViewModelProtocol?
    
    var reslut = Box(LoginStatus.fail(message: "unknown error"))
    
    var loadingStatus = Box(LoadingStatus.complete)
        
    func loginRequest(email: String?, password: String?) {
        guard let email = email, email.count > 0 else {
            delegate?.promptAlert(title: "Please input email", message: nil)
            return
        }
        
        guard let password = password, password.count > 0 else {
            delegate?.promptAlert(title: "Please input password", message: nil)
            return
        }
        
        loadingStatus.value = .loading
        ApiService.loginApiRequest(email: email, password: password) { (res) in
            self.loadingStatus.value = .complete
            guard let theRes = res else {
                return
            }

            self.reslut.value = theRes
            self.delegate?.loginComplete()
        }
    }
    
    
}
