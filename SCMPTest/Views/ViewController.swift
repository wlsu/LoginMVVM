//
//  ViewController.swift
//  SCMPTest
//
//  Created by Vincent Su on 25/4/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @UsesAutoLayout
    var loginView =  LoginTextFieldsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(loginView)

        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    


}

