//
//  ResultViewController.swift
//  SCMPTest
//
//  Created by su on 27/4/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @UsesAutoLayout
    var resultLabel = UILabel()
    
    var reslut = LoginStatus.fail(message: "unknown error")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    private func setupView() {
        self.title = "Result"
        view.backgroundColor = UIColor.white
        
        
        switch reslut {
        case .success(let token):
            resultLabel.text = "Success: \(token)"
        case .fail(let message):
            resultLabel.text = "Failed: \(message)"
        }
        
        self.view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
