//
//  OnboardingView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/27/20.
//

import UIKit

class OnboardingView: UIView {

    let welcomeLabel = UILabel()
    
    let createAccountButton = UIButton()
    let signInButton = UIButton()
    
    var createAccountAction: (() -> Void)?
    var signInAction: (() -> Void)?
    
    
    init(createAccountAction: @escaping() -> Void, signInAction: @escaping() -> Void) {
        self.createAccountAction = createAccountAction
        self.signInAction = signInAction
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnboardingView {
    private func setupSubviews() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Welcome to AUBMarketplace!"
        welcomeLabel.setDynamicFont(forTextStyle: .largeTitle)
        welcomeLabel.numberOfLines = 0
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .medium)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.setBackgroundColor(color: .systemGreen, forState: .normal)
        createAccountButton.rounded(cornerRadius: 8)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .medium)
        signInButton.setTitleColor(.systemGreen, for: .normal)
        signInButton.setBackgroundColor(color: .systemGray6, forState: .normal)
        signInButton.rounded(cornerRadius: 8)
    }
    
    private func setupConstraints() {
        createAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [createAccountButton, signInButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .vertical
        buttonStackView.alignment = .fill
        buttonStackView.spacing = 16
        
        addSubview(welcomeLabel)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupTargets() {
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc private func didTapCreateAccount() {
        createAccountAction?()
    }
    
    @objc private func didTapSignIn() {
        signInAction?()
    }
}
