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
    
    let departmentButton = ListButton(title: "Department")
    let majorButton = ListButton(title: "Major")
    
    let continueButton = FilledButton(textColor: .white, backgroundColor: .systemGreen)
    
    init(userType: UserType) {
        self.userType = userType
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
//        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subviews Setup
extension SignUpCredentialsView {
    private func setupSubviews() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        setupEmailTextField(emailTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        setupPasswordTextField(passwordTextField)
        
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        setupPasswordTextField(repeatPasswordTextField)
        
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        setupCompanyTextField(companyTextField)
        
        departmentButton.translatesAutoresizingMaskIntoConstraints = false
        
        majorButton.translatesAutoresizingMaskIntoConstraints = false
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle((userType == .company ? "Continue" : "Finish"), for: .normal)
    }
    
    private func setupCompanyTextField(_ textField: UITextField) {
        textField.textContentType = .organizationName
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.keyboardType = .alphabet
        textField.adjustsFontSizeToFitWidth = true;
        textField.minimumFontSize = 10.0; //Optionally specify min size
    }
    
    private func setupEmailTextField(_ textField: UITextField) {
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.adjustsFontSizeToFitWidth = true;
        textField.minimumFontSize = 10.0; //Optionally specify min size
    }
    
    private func setupPasswordTextField(_ textField: UITextField) {
        textField.textContentType = .newPassword
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
    }
}

extension SignUpCredentialsView {
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, repeatPasswordTextField, departmentButton, majorButton])
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
