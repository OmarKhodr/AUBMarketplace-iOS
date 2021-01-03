//
//  SignupView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/16/20.
//

import UIKit

class SignupView: UIView {
    
    let createLabel = UILabel()
    let backButton = UIButton()
    let nameTextField = CustomTextField()
    let emailTextField = CustomTextField()
    let passwordTextField = CustomTextField()
    let createAccountButton = UIButton()
    
    let backAction: (() -> Void)?
    let createAction: (() -> Void)?

    init(backAction: @escaping () -> Void, createAction: @escaping () -> Void) {
        self.backAction = backAction
        self.createAction = createAction
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setup Methods
extension SignupView {
    private func setupViews() {
        createLabel.text = "Create an account"
        createLabel.font = .preferredFont(forTextStyle: .largeTitle)
        createLabel.adjustsFontForContentSizeCategory = true
        
        let backImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        nameTextField.placeholder = "Name"
        nameTextField.textContentType = .name
        nameTextField.autocapitalizationType = .words
        
        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Password"
        passwordTextField.textContentType = .newPassword
        passwordTextField.autocapitalizationType = .none
        #warning("TODO: passwordTextField.passwordRules")
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.label, for: .normal)
        createAccountButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        
    }
    
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, createAccountButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.setCustomSpacing(30, after: passwordTextField)
        
        layoutTextField(nameTextField, stackView)
        layoutTextField(emailTextField, stackView)
        layoutTextField(passwordTextField, stackView)
        
        addSubview(backButton)
        addSubview(createLabel)
        addSubview(stackView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            createLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            createLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
    }
    
    func layoutTextField(_ textField: UITextField, _ stackView: UIStackView) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.anchor(top: nil,
                                 leading: stackView.leadingAnchor,
                                 bottom: nil,
                                 trailing: stackView.trailingAnchor)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension SignupView {
    @objc private func didTapBackButton() {
        backAction?()
    }
    
    @objc private func didTapCreateButton() {
        createAction?()
    }
}
