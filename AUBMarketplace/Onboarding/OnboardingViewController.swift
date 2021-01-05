//
//  OnboardingViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/27/20.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    override func loadView() {
        view = OnboardingView(createAccountAction: didTapCreateAccount, signInAction: didTapSignIn)
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

//MARK: - Action Setup
extension OnboardingViewController {
    private func didTapCreateAccount() {
        let basicInfoVC = SignUpBasicInfoViewController()
        show(basicInfoVC, sender: self)
    }
    
    private func didTapSignIn() {
        let signInVC = SigninViewController()
        show(signInVC, sender: self)
    }
}
