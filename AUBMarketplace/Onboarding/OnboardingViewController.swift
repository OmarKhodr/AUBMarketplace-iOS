//
//  OnboardingViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/27/20.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = OnboardingView(createAccountAction: didTapCreateAccount, signInAction: didTapSignIn)
        view.backgroundColor = .systemBackground
    }

}

//MARK: - Action Setup
extension OnboardingViewController {
    private func didTapCreateAccount() {
        print("Tapped Create!")
        let basicInfoVC = SignUpBasicInfoViewController()
        show(basicInfoVC, sender: self)
    }
    
    private func didTapSignIn() {
        print("Tapped Sign In!")
    }
}
