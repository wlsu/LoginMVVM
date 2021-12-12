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
        
        loginView.viewModel.loadingStatus.addObserver(self) { [weak self] (loadingStatus) in
            switch loadingStatus {
            case .complete:
                self?.hideSpinner()
            case .loading:
                self?.showSpinner()
            }
        }
        
        loginView.viewModel.alertContent.addObserver(self) { [unowned self] newValue in
            self.alert(title: newValue.title, message: newValue.message)
        }
        
        loginView.viewModel.apiResult.addObserver(self) { [unowned self] newValue in
            let resultVC = ResultViewController()
            resultVC.reslut = newValue
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        
        
        
    }
    
    deinit {
        loginView.viewModel.loadingStatus.removeObserver(self)
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
    }

}



