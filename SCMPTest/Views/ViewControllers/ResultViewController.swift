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
    
    var viewModel = ResultVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        viewModel.reslut.bind { [weak self](loginResult) in
            switch loginResult {
            case .success(let token):
                self?.resultLabel.text = "Success: \(token)"
            case .fail(let message):
                self?.resultLabel.text = "Failed: \(message)"
            }
        }
        
    }
    
    private func setupView() {
        self.title = "Result"
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
