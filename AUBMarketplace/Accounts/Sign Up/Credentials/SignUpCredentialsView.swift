//
//  SignUpCredentialsView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/29/20.
//

import UIKit

class SignUpCredentialsView: UIView {
    
    let userType: UserType

    let emailTextField = BoldBorderlessTextField(placeholder: "Email")
    let passwordTextField = BoldBorderlessTextField(placeholder: "Password")
    let repeatPasswordTextField = BoldBorderlessTextField(placeholder: "Repeat Password")
    
    let companyTextField = BoldBorderlessTextField(placeholder: "Company")
    
    let majorListButton = ListButton(title: "Major")
    
    let continueButton = FilledButton(textColor: .white, backgroundColor: .systemGreen)
    
    let majorAction: (() -> Void)?
    let continueAction: (() -> Void)?
    
    init(userType: UserType,
         majorAction: @escaping() -> Void,
         continueAction: @escaping() -> Void) {
        
        self.userType = userType
        self.majorAction = majorAction
        self.continueAction = continueAction
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        setupTargets()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subviews Setup
extension SignUpCredentialsView {
    private func setupSubviews() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.setupForEmailContent()
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.setupForNewPasswordContent()
        
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.setupForNewPasswordContent()
        
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        companyTextField.setupForCompanyContent()
        
        majorListButton.translatesAutoresizingMaskIntoConstraints = false
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle(("Continue"), for: .normal)
        
        if userType == .company {
            majorListButton.isHidden = true
        } else {
            companyTextField.isHidden = true
        }
    }
}

//MARK: - Constraints Setup
extension SignUpCredentialsView {
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, repeatPasswordTextField, companyTextField, majorListButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        
        addSubview(stackView)
        addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            continueButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -291-20),
            continueButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
}

//MARK: - Target Setup
extension SignUpCredentialsView {
    private func setupTargets() {
        majorListButton.addTarget(self, action: #selector(didTapMajorListButton), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    @objc private func didTapMajorListButton() {
        majorAction?()
    }
    
    @objc private func didTapContinueButton() {
        continueAction?()
    }
}
