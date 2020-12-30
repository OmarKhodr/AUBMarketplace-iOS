//
//  SignUpBasicInfoView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/28/20.
//

import UIKit

class SignUpBasicInfoView: UIView {

    let titleLabel = UILabel()
    let firstNameTextField = BoldBorderlessTextField(placeholder: "First Name")
    let lastNameTextField = BoldBorderlessTextField(placeholder: "Last Name")
    let phoneTextField = BoldBorderlessTextField(placeholder: "Phone")
    var continueButton = FilledButton(textColor: .white, backgroundColor: .systemGreen)
    
    var continueAction: (() -> Void)?
    
    init(continueAction: @escaping() -> Void) {
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

extension SignUpBasicInfoView {
    private func setupSubviews() {
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        setupNameTextField(firstNameTextField)
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        setupNameTextField(lastNameTextField)
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        setupPhoneTextField(phoneTextField)

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Continue", for: .normal)
    }
    
    private func setupNameTextField(_ textField: UITextField) {
        textField.textContentType = .name
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.keyboardType = .alphabet
    }
    
    private func setupPhoneTextField(_ textField: UITextField) {
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        textField.returnKeyType = .done
    }
}

extension SignUpBasicInfoView {
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, phoneTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        
        addSubview(stackView)
        addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            continueButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -291-20),
            continueButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
}

extension SignUpBasicInfoView {
    private func setupTargets() {
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    @objc private func didTapContinueButton() {
        continueAction?()
    }
}
