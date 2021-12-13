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
    
    var reslut = LoginStatus.fail(message: "unknown error")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        // Attempted to read an unowned reference but the object was already deallocated
        LoginState.apiResult.addObserver(self) { [unowned self ] newValue in
            self.renderResultLabel(reslut: newValue)
        }
        
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
