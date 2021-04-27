//
//  LoginViewModel.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

protocol LoginViewModelProtocol {
    func loginComplete()
}

class LoginViewModel {
    
    static var shared = LoginViewModel()
    
    var delegate: LoginViewModelProtocol?
    
    var reslut = Box(LoginStatus.fail(message: "unknown error"))
    
    var loadingStatus = Box(LoadingStatus.complete)
        
    func loginRequest(email: String, password: String) {
        loadingStatus.value = .loading
        ApiService.loginApiRequest(email: email, password: password) { (res) in
            self.loadingStatus.value = .complete
            guard let theRes = res else {
                return
            }
            print("get api result: \(theRes.value())")
            self.reslut.value = theRes
            self.delegate?.loginComplete()
        }
    }
    
    
}
