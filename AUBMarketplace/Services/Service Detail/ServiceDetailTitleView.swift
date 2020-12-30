//
//  ServiceDetailTitleView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/25/20.
//

import UIKit

class ServiceDetailTitleView: UIView {
    
    let service: Service
    
    let requestorProfilePic = UIImageView()
    let titleLabel = UILabel()
    let requestorLabel = UILabel()
    
    let applyButton = UIButton()
    let moreButton = UIButton()
    
    let applyAction: () -> Void
    
    init(service: Service, applyAction: @escaping() -> Void) {
        self.service = service
        self.applyAction = applyAction
        super.init(frame: .zero)
        
        setupSubviews()
        setupConstraints()
        configureData()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Subviews Setup
extension ServiceDetailTitleView {
    private func setupSubviews() {
        requestorProfilePic.translatesAutoresizingMaskIntoConstraints = false
        requestorProfilePic.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.setDynamicFont(forTextStyle: .title2, weight: .medium)
        
        requestorLabel.translatesAutoresizingMaskIntoConstraints = false
        requestorLabel.textColor = .secondaryLabel
        requestorLabel.numberOfLines = 1
        requestorLabel.setDynamicFont(forTextStyle: .subheadline)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.setTitle("APPLY", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .bold)
        applyButton.setBackgroundColor(color: .systemGreen, forState: .normal)
        applyButton.rounded(cornerRadius: 15)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setImage(UIImage(systemName: "ellipsis.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        moreButton.tintColor = .systemGreen
    }
}

//MARK: - Constraints Setup
extension ServiceDetailTitleView {
    private func setupConstraints() {
        requestorProfilePic.heightAnchor.constraint(equalToConstant: 120).isActive = true
        requestorProfilePic.widthAnchor.constraint(equalToConstant: 120).isActive = true
        requestorProfilePic.rounded(cornerRadius: 60)
        
        applyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        applyButton.widthAnchor.constraint(greaterThanOrEqualTo: applyButton.titleLabel!.widthAnchor, constant: 25).isActive = true
        
        let textVStack = UIStackView(arrangedSubviews: [
            titleLabel,
            requestorLabel,
        ])
        textVStack.translatesAutoresizingMaskIntoConstraints = false
        textVStack.axis = .vertical
        textVStack.distribution = .fill
        textVStack.alignment = .leading
        textVStack.spacing = 3
        
        addSubview(requestorProfilePic)
        addSubview(textVStack)
        addSubview(applyButton)
        addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            
            requestorProfilePic.topAnchor.constraint(equalTo: topAnchor),
            requestorProfilePic.leadingAnchor.constraint(equalTo: leadingAnchor),
            requestorProfilePic.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textVStack.topAnchor.constraint(equalTo: topAnchor),
            textVStack.leadingAnchor.constraint(equalTo: requestorProfilePic.trailingAnchor, constant: 16),
            textVStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            applyButton.leadingAnchor.constraint(equalTo: requestorProfilePic.trailingAnchor, constant: 16),
            applyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
}

//MARK: - Data Setup
extension ServiceDetailTitleView {
    private func configureData() {
        requestorProfilePic.image = service.requestorImage
        titleLabel.text = service.title
        requestorLabel.text = service.requestor
    }
}

//MARK: - Target Setup
extension ServiceDetailTitleView {
    private func setupTargets() {
        applyButton.addTarget(self, action: #selector(didTapApplyButton), for: .touchUpInside)
    }
    
    @objc private func didTapApplyButton() {
        applyAction()
    }
}
