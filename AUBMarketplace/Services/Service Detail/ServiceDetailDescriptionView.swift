//
//  ServiceDetailDescriptionView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/26/20.
//

import UIKit

class ServiceDetailDescriptionView: UIView {

    let service: Service
    
    let titleLabel = UILabel()
    let datePosted = UILabel()
    let descriptionLabel = UILabel()
    
    init(service: Service) {
        self.service = service
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ServiceDetailDescriptionView {
    private func setupSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Description"
        titleLabel.setDynamicFont(forTextStyle: .title2)
//        titleLabel.backgroundColor = .systemGreen
        
        datePosted.translatesAutoresizingMaskIntoConstraints = false
        datePosted.text = "5d ago"
        datePosted.textColor = .secondaryLabel
        datePosted.setDynamicFont(forTextStyle: .callout)
        datePosted.textAlignment = .right
//        datePosted.backgroundColor = .systemBlue
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = service.description
        descriptionLabel.textAlignment = .natural
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setDynamicFont(forTextStyle: .body)
//        descriptionLabel.backgroundColor = .systemTeal
    }
}

extension ServiceDetailDescriptionView {
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(datePosted)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            
            datePosted.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            datePosted.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: datePosted.leadingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
