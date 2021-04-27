//
//  LoginTextfieldsView.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import UIKit

class LoginTextFieldsView: UIView {
    
    @UsesAutoLayout
    var loginStack = UIStackView()
    
    @UsesAutoLayout
    var loginBtn = UIButton()
    
    @UsesAutoLayout
    var emailTextfield = UITextField()
    
    @UsesAutoLayout
    var pwdTextfield = UITextField()
    
    var viewModel = LoginViewModel.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // setup views here
        loginStack.axis = .vertical
        loginStack.alignment = .fill
        loginStack.distribution = .fillProportionally
        addSubview(loginStack)
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: self.topAnchor),
            loginStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loginStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loginStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // 2 text fields stack view
        let textfieldsStack = UIStackView()
        textfieldsStack.distribution = .fillEqually
        textfieldsStack.axis = .vertical
        loginStack.addArrangedSubview(textfieldsStack)
        textfieldsStack.translatesAutoresizingMaskIntoConstraints = false
        // need this to make it works
        NSLayoutConstraint.activate([
            textfieldsStack.heightAnchor.constraint(equalToConstant: 90),
            textfieldsStack.leadingAnchor.constraint(equalTo: loginStack.leadingAnchor),
            textfieldsStack.trailingAnchor.constraint(equalTo: loginStack.trailingAnchor)
        ])
        
        
        emailTextfield.delegate = self
        emailTextfield.autocorrectionType = .no
        emailTextfield.autocapitalizationType = .none
        emailTextfield.clearButtonMode = .always
        emailTextfield.backgroundColor = UIColor.gray
        emailTextfield.keyboardType = .emailAddress
        emailTextfield.returnKeyType = .next
        
        
        pwdTextfield.delegate = self
        pwdTextfield.autocorrectionType = .no
        pwdTextfield.autocapitalizationType = .none
        pwdTextfield.clearButtonMode = .always
        pwdTextfield.backgroundColor = UIColor.green
        pwdTextfield.isSecureTextEntry = true
        pwdTextfield.returnKeyType = .go
        
        textfieldsStack.addArrangedSubview(emailTextfield)
        textfieldsStack.addArrangedSubview(pwdTextfield)
        
        // Button
        loginBtn.setTitle("Login", for: UIControl.State.normal)
        loginBtn.setTitleColor(UIColor.black, for: .normal)
        loginBtn.addTarget(self, action: #selector(loginButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        loginStack.addArrangedSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.heightAnchor.constraint(equalToConstant: 45),
            loginBtn.leadingAnchor.constraint(equalTo: loginStack.leadingAnchor),
            loginBtn.trailingAnchor.constraint(equalTo: loginStack.trailingAnchor)
        ])
        
      
        viewModel.loadingStatus.bind { [weak self] (loadingStatus) in
            switch loadingStatus {
            case .complete:
                self?.loginBtn.isEnabled = true
                self?.loginBtn.setTitle("Login", for: .normal)
            case .loading:
                self?.loginBtn.isEnabled = false
                self?.loginBtn.setTitle("Loading", for: .normal)
            }
        }
        
    }
    
    
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text else {
            // trigger VC to alert
            return
        }
        
        guard let password = pwdTextfield.text else {
            // trigger VC to alert
            return
        }
        
        viewModel.loginRequest(email: email, password: password)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginTextFieldsView: UITextFieldDelegate {
    @objc func textFieldContentDidChange() {
//        contentDidChange?(textField.text ?? "")
                
//        if case .email = type, textField.text?.count == 0 {
//            status = .normal
//            UserDefaults.standard.removeObject(forKey: NSUserDefaultLastUserEmail)
//            UserDefaults.standard.synchronize()
//            HKTVHelper.deleteKeychainData(NSUserDefaultLastUserPassword)
//            return
//        }
//
//        if case .password = type, textField.text?.count == 0 {
//            status = .normal
////            HKTVHelper.deleteKeychainData(NSUserDefaultLastUserPassword)
//            return
//        }
        
//        status = .typing
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        status = .typing
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        status = .normal
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        shouldReturn?()
        return false
    }
    
}
