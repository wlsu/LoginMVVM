//
//  SCMPBaseViewController.swift
//  SCMPTest
//
//  Created by su on 28/4/2021.
//

import UIKit

class SCMPBaseViewController: UIViewController {
    
    var spinnerVC: SpinnerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showSpinner() {
        spinnerVC = SpinnerViewController()
        guard let spinner = spinnerVC  else {
            return
        }
        
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)

    }
    
    func hideSpinner() {
        guard let spinner = spinnerVC else {
            return
        }
        
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
        spinnerVC = nil
        
    }

}
