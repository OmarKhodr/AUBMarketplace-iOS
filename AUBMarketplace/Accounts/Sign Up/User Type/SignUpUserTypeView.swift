//
//  SignUpUserTypeView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/29/20.
//

import UIKit

class SignUpUserTypeView: UIView {

    let titleLabel = UILabel()
    var studentButton: FilledButton!
    var facultyButton: FilledButton!
    var companyButton: FilledButton!
    
    var userTypeAction: ((UserType) -> Void)?
    
    init(userTypeAction: @escaping(UserType) -> Void) {
        self.userTypeAction = userTypeAction
        
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
extension SignUpUserTypeView {
    private func setupSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "I'm a..."
        titleLabel.setDynamicFont(forTextStyle: .title2, weight: .medium)
        titleLabel.textAlignment = .center
        
        studentButton = createFilledButton(title: "Student")
        facultyButton = createFilledButton(title: "Faculty Member")
        companyButton = createFilledButton(title: "Company Representative")
    }
    
    private func createFilledButton(title: String) -> FilledButton {
        let button = FilledButton(textColor: .white, backgroundColor: .systemGreen)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        return button
    }
}

//MARK: - Constraints Setup
extension SignUpUserTypeView {
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            studentButton,
            facultyButton,
            companyButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.setCustomSpacing(50, after: titleLabel)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

//MARK: - Target Setup
extension SignUpUserTypeView {
    private func setupTargets() {
        studentButton.addTarget(self, action: #selector(didTapStudent), for: .touchUpInside)
        facultyButton.addTarget(self, action: #selector(didTapFaculty), for: .touchUpInside)
        companyButton.addTarget(self, action: #selector(didTapCompany), for: .touchUpInside)
    }
    
    @objc private func didTapStudent() {
        userTypeAction?(.student)
    }
    
    @objc private func didTapFaculty() {
        userTypeAction?(.faculty)
    }
    
    @objc private func didTapCompany() {
        userTypeAction?(.company)
    }
}
