//
//  SignInView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/8/21.
//

import UIKit

class SignInView: UIView {

    let titleLabel = UILabel()
    let emailTextField = FilledTextField()
    let passwordTextField = FilledTextField()
    let signInButton = FilledButton(textColor: .white, backgroundColor: .systemBlue)
    
    let signInAction: () -> Void
    
    init(signInAction: @escaping () -> Void) {
        self.signInAction = signInAction
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subviews
extension SignInView {
    private func setupSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Welcome Back!"
        titleLabel.setDynamicFont(forTextStyle: .largeTitle, weight: .bold)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.textField.placeholder = "Email"
        emailTextField.textField.text = "mtm12@mail.aub.edu"
        emailTextField.textField.setupForEmailContent()
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.textField.placeholder = "Password"
        passwordTextField.textField.text = "Hello.123"
        passwordTextField.textField.setupForPasswordContent()
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.rounded(cornerRadius: 16)
        signInButton.isEnabled = false
    }
}


//MARK: - Constraints
extension SignInView {
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            emailTextField,
            passwordTextField,
            signInButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.setCustomSpacing(16, after: emailTextField)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
}

//MARK: - Targets
extension SignInView {
    private func setupTargets() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        signInAction()
    }
}
