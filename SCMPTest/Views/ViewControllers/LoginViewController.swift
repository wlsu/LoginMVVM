//
//  ViewController.swift
//  SCMPTest
//
//  Created by Vincent Su on 25/4/2021.
//

import UIKit

class LoginViewController: SCMPBaseViewController, ObserverProtocol {
    
    @UsesAutoLayout
    var loginView =  LoginTextFieldsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        LoginViewState.loadingStatus.addObserver(self) { [weak self] (loadingStatus) in
            switch loadingStatus {
            case .complete:
                self?.hideSpinner()
            case .loading:
                self?.showSpinner()
            }
        }
    }
    
    deinit {
        LoginViewState.loadingStatus.removeObserver(self)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        self.title = "Login"
        
        self.view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loginView.delegate = self
    }

}

extension LoginViewController: LoginViewProtocol {
    func resultHandler(result: LoginStatus) {
        let resultVC = ResultViewController()
        resultVC.reslut = result
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    

    func promptAlert(title: String?, message: String?) {
        self.alert(title: title, message: message)
    }
}

