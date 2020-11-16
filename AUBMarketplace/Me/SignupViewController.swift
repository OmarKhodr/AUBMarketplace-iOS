//
//  SignupViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/16/20.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = SignupView {
            self.navigationController?.popViewController(animated: true)
        } createAction: {
            self.performSegue(withIdentifier: "createAccount", sender: self)
        }
    }

}
