//
//  ViewController.swift
//  SCMPTest
//
//  Created by Vincent Su on 25/4/2021.
//

import UIKit

class LoginViewController: SCMPBaseViewController {
    
    @UsesAutoLayout
    var loginView =  LoginTextFieldsView()
    
    var viewModel = LoginVCViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        self.title = "Login"
        
        self.view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loginView.delegate = self
    
        viewModel.loadingStatus.bind { [weak self] (loadingStatus) in
            switch loadingStatus {
            case .complete:
                self?.hideSpinner()
            case .loading:
                self?.showSpinner()
            }
        }
    }

}

extension LoginViewController: LoginViewProtocol {
    func updateLoadingStatus(status: LoadingStatus) {
        viewModel.loadingStatus.value = status
    }
    
    func loginComplete(result: LoginStatus) {
        let resultVC = ResultViewController()
        resultVC.viewModel.reslut.value = result
        self.navigationController?.pushViewController(resultVC, animated: true)
    }

    func promptAlert(title: String?, message: String?) {
        self.alert(title: title, message: message)
    }
}

