//
//  ListButton.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/30/20.
//

import UIKit

class ListButton: UIControl {
    
    let title: String
    
    let titleLabel = UILabel()
    let chosenOptionLabel = UILabel()
    let disclosureIndicator = UIImageView()

    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListButton {
    
    private func setupSubviews() {
        backgroundColor = .systemGray6
        rounded(cornerRadius: 8)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.setDynamicFont(forTextStyle: .body)
        
        chosenOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        chosenOptionLabel.text = "None"
        chosenOptionLabel.textColor = .secondaryLabel
        chosenOptionLabel.setDynamicFont(forTextStyle: .body)
        
        disclosureIndicator.translatesAutoresizingMaskIntoConstraints = false
        disclosureIndicator.contentMode = .scaleAspectFit
        disclosureIndicator.image = UIImage(systemName: "chevron.right")
        disclosureIndicator.tintColor = .secondaryLabel
    }
    
    private func setupConstraints() {
        let optionStackView = UIStackView(arrangedSubviews: [chosenOptionLabel, disclosureIndicator])
        optionStackView.translatesAutoresizingMaskIntoConstraints = false
        optionStackView.axis = .horizontal
        optionStackView.alignment = .center
        optionStackView.spacing = 5
        
        addSubview(titleLabel)
        addSubview(optionStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            optionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            optionStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: optionStackView.leadingAnchor, constant: -20)
        ])
    }
}
