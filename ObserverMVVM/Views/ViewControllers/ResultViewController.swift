//
//  ResultViewController.swift
//  SCMPTest
//
//  Created by su on 27/4/2021.
//

import UIKit

class ResultViewController: UIViewController, ObserverProtocol {
    
    @UsesAutoLayout
    var resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        LoginState.apiResult.addObserver(self) { [unowned self ] newValue in
            self.renderResultLabel(reslut: newValue)
        }
        /*
         addObserver self actually not holding self instance, just use it's id
         Crash: Attempted to read an unowned reference but the object was already deallocated
         
         As:
         when back to login page, this result vc can be deaaloced, as nothing holding it, here add observer self, just use it id
         if not remove observer, then when login again, it get result then, will triger completion block,
         but that time still hv not init result vc, which caused, crash.
         
         so when deinit removeObserver fixed the issue
         
         */
        
    }
    
    deinit {
        LoginState.apiResult.removeObserver(self)
        print("deinited ResultViewController")
    }
    
    func renderResultLabel(reslut: LoginStatus) {
        switch reslut {
        case .success(let token):
            resultLabel.text = "Success: \(token)"
        case .fail(let message):
            resultLabel.text = "Failed: \(message)"
        }
    }
    
    private func setupView() {
        self.title = "Result"
        view.backgroundColor = UIColor.white
        
        renderResultLabel(reslut: LoginState.apiResult.value)
        
        
        self.view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
