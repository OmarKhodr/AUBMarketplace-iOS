//
//  FilledTextField.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/8/21.
//

import UIKit

class FilledTextField: UIView {

    let textField = UITextField()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .systemGray6
        rounded(cornerRadius: 16.0)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
