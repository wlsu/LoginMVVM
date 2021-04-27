//
//  ViewController.swift
//  SCMPTest
//
//  Created by Vincent Su on 25/4/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @UsesAutoLayout
    var loginView =  LoginTextFieldsView()
    
    var loginViewModel = LoginViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        LoginViewModel.shared.delegate = self        
    }

}

extension LoginViewController: LoginViewModelProtocol {
    func loginComplete() {
        let resultVC = ResultViewController()
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
}

