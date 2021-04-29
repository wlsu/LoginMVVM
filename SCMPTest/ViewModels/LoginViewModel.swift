//
//  LoginViewModel.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

protocol LoginViewModelProtocol {
    func loginComplete(result: LoginStatus)
    func promptAlert(title: String?, message: String?)
    func updateLoadingStatus(status: LoadingStatus)
}

class LoginViewModel {
    
    var delegate: LoginViewModelProtocol?
        
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
        self.delegate?.updateLoadingStatus(status: .loading)
        ApiService.loginApiRequest(email: email, password: password) { (res) in
            self.delegate?.updateLoadingStatus(status: .complete)
            self.loadingStatus.value = .complete
            guard let theRes = res else {
                self.delegate?.promptAlert(title: "Unknow error", message: "Please try again later")
                return
            }

            self.delegate?.loginComplete(result: theRes)
        }
    }
    
    
}
