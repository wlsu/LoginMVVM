//
//  LoginTextfieldsView.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import UIKit

class LoginTextFieldsView: UIView, ObserverProtocol {
    
    @UsesAutoLayout
    var loginStack = UIStackView()
    
    @UsesAutoLayout
    var textfieldsStack = UIStackView()
    
    @UsesAutoLayout
    var loginBtn = UIButton()
    
    @UsesAutoLayout
    var emailTextfield = UITextField()
    
    @UsesAutoLayout
    var pwdTextfield = UITextField()
    
    var viewModel = LoginViewModel()
    
    enum TextFieldType {
        case email
        case password
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        viewModel.loadingStatus.addObserver(self) { [unowned self] newValue in
            switch newValue {
            case .complete:
                self.loginBtn.isEnabled = true
                self.loginBtn.setTitle("Login", for: .normal)
            case .loading:
                self.loginBtn.isEnabled = false
                self.loginBtn.setTitle("Logining", for: .normal)
            }
        }
        
    }
    
    deinit {
        viewModel.loadingStatus.removeObserver(self)
    }
    
    @objc private func loginButtonPressed(_ sender: UIButton) {
        
        self.endEditing(false)
        makeLoginRequest()
    }
    
    func makeLoginRequest() {
        viewModel.loginRequest(email: emailTextfield.text, password: pwdTextfield.text)
    }
    
    func setupViews() {
        // loginStack: vertical stackView including textfieldsStack + login button
        loginStack.axis = .vertical
        loginStack.distribution = .fillProportionally
        loginStack.spacing = 25
        addSubview(loginStack)
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: self.topAnchor),
            loginStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loginStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loginStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // textfieldsStack:stackView including 2 textfields
        textfieldsStack.axis = .vertical
        textfieldsStack.distribution = .fillEqually
        textfieldsStack.spacing = 15
        loginStack.addArrangedSubview(textfieldsStack)
        NSLayoutConstraint.activate([
            textfieldsStack.heightAnchor.constraint(equalToConstant: 90),
            textfieldsStack.leadingAnchor.constraint(equalTo: loginStack.leadingAnchor),
            textfieldsStack.trailingAnchor.constraint(equalTo: loginStack.trailingAnchor)
        ])

        setupTextFields(textfieldType: .email, textfield: emailTextfield)
        setupTextFields(textfieldType: .password, textfield: pwdTextfield)
        
        textfieldsStack.addArrangedSubview(emailTextfield)
        textfieldsStack.addArrangedSubview(pwdTextfield)
        
        // Button
        loginBtn.setTitle("Login", for: UIControl.State.normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.addTarget(self, action: #selector(loginButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        loginStack.addArrangedSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.heightAnchor.constraint(equalToConstant: 45),
            loginBtn.leadingAnchor.constraint(equalTo: loginStack.leadingAnchor),
            loginBtn.trailingAnchor.constraint(equalTo: loginStack.trailingAnchor)
        ])
        loginBtn.backgroundColor = UIColor.systemGreen
    }
    
    private func setupTextFields(textfieldType: TextFieldType, textfield: UITextField) {
        
        textfield.delegate = self
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.clearButtonMode = .always
        textfield.addBottomBorder()
        
        switch textfieldType {
        case .email:
            textfield.keyboardType = .emailAddress
            textfield.returnKeyType = .next
            textfield.attributedPlaceholder = NSAttributedString(string: "mobile number / email address", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.accessibilityIdentifier = "loginEmailTextfield"
        case .password:
            textfield.isSecureTextEntry = true
            textfield.returnKeyType = .go
            textfield.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.accessibilityIdentifier = "loginPasswordTextfield"
        }
    }
    


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginTextFieldsView: UITextFieldDelegate {
    @objc func textFieldContentDidChange() {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            pwdTextfield.becomeFirstResponder()
        } else if textField == pwdTextfield {
            makeLoginRequest()
            textField.resignFirstResponder()
        } else {
           // should never happen as only 2 textfields
        }

       
        return false
    }
    
}
