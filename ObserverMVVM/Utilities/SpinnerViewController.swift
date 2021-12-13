//
//  SpinnerViewController.swift
//  SCMPTest
//
//  Created by su on 28/4/2021.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    @UsesAutoLayout
    var spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        spinner.startAnimating()
    }
}
