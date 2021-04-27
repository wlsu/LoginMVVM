//
//  ResultViewController.swift
//  SCMPTest
//
//  Created by su on 27/4/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    var viewModel = LoginViewModel.shared
    
    @UsesAutoLayout
    var resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Result"
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        var resultString = ""
        viewModel.reslut.bind { [weak self](loginResult) in
            switch loginResult {
            case .success(let token):
                resultString = "Success: \(token)"
            case .fail(let message):
                resultString = "Failed: \(message)"
            }
            self?.resultLabel.text = resultString
        }
        
    }
    

   

}
