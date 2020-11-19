//
//  SigninViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/7/20.
//

import UIKit

class SigninViewController: UIViewController {
    
    let welcomeLabel = UILabel()
    let dontLabel = UILabel()
    let emailTextField = CustomTextField()
    let passwordTextField = CustomTextField()
    let signInButton = UIButton()
    let createAccountButton = UIButton()
    
    let authenticator = AuthenticationManager()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authenticator.delegate = self
        setupViews()
        setupLayout()
    }
    
}

//MARK: - View setup methods
extension SigninViewController {
    
    func setupViews() {
        
        welcomeLabel.text = "Welcome to AUBMarketplace!"
        welcomeLabel.setDynamicFont(forTextStyle: .largeTitle, weight: .bold)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        
        emailTextField.placeholder = "Email"
        emailTextField.textColor = .label
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .label
        passwordTextField.textContentType = .password
        passwordTextField.autocapitalizationType = .none
        #warning("TODO: passwordTextField.passwordRules")
        passwordTextField.isSecureTextEntry = true
        
        //TESTING
        emailTextField.text = "ohk04@mail.aub.edu"
        passwordTextField.text = "Arsena123"
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = .systemGreen
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signInButton.rounded(cornerRadius: 8)
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signInButton.startAnimatingPressActions()
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.label, for: .normal)
        createAccountButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        
    }
    
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, emailTextField, passwordTextField, signInButton, createAccountButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.setCustomSpacing(100, after: welcomeLabel)
        stackView.setCustomSpacing(25, after: passwordTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.anchor(top: nil,
                              leading: stackView.leadingAnchor,
                              bottom: nil,
                              trailing: stackView.trailingAnchor)
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.anchor(top: nil,
                                 leading: stackView.leadingAnchor,
                                 bottom: nil,
                                 trailing: stackView.trailingAnchor)
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signInButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
}


//MARK: - Action Methods
extension SigninViewController {
    
    //networking version
//    @objc func didTapSignIn() {
//        if let userEmail = emailTextField.text, let userPassword = passwordTextField.text {
//            authenticator.authenticate(email: userEmail, password: userPassword)
//        } else {
//            print("Email or password fields not filled!")
//        }
//    }
    
    @objc private func didTapSignIn() {
        self.performSegue(withIdentifier: "authenticate", sender: self)
    }
    
    @objc private func didTapCreateAccount() {
        self.performSegue(withIdentifier: "signup", sender: self)
    }
    
}


//MARK: - AuthenticationManagerDelegate Methods
extension SigninViewController: AuthenticationManagerDelegate {
    func didFailAuthenticationWithError(_ manager: AuthenticationManager, error: Error) {
        print(error)
    }
    
    func didAuthenticate(_ manager: AuthenticationManager, token: String) {
        print("Authentication Successful!")
        DispatchQueue.main.async {
            self.defaults.set(token, forKey: "token")
            self.performSegue(withIdentifier: "authenticate", sender: self)
        }
    }
}
