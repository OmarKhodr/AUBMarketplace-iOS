//
//  SigninViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/7/20.
//

import UIKit

class SigninViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var signInView: SignInView!
    var textFieldsDelegate: SequentialTextFieldDelegate!
    
    override func loadView() {
        signInView = SignInView(signInAction: didTapSignIn)
        view = signInView
        
        
        textFieldsDelegate = SequentialTextFieldDelegate(textFields: [
            signInView.emailTextField.textField,
            signInView.passwordTextField.textField,
        ],
        finishButton: signInView.signInButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        signInView.emailTextField.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}


//MARK: - Actions
extension SigninViewController {
    
    private func didTapSignIn() {
        if let userEmail = signInView.emailTextField.textField.text,
           let userPassword = signInView.passwordTextField.textField.text {
            
            UserManager.shared.signIn(email: userEmail, password: userPassword) { (token) in
                print("Authentication Successful!")
                self.defaults.set(token.token, forKey: "token")
                let mainTabBar = MainTabBarController()
                self.show(mainTabBar, sender: self)
            }
            
        } else {
            
            print("Email or password fields not filled!")
            
        }
    }
    
}
