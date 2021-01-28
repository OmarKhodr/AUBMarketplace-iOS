//
//  ProductDetailActionView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/28/21.
//

import UIKit

class ProductDetailActionView: UIView {

    let saveButton = UIButton()
    let editButton = UIButton()
    let buyButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductDetailActionView {
    private func setupSubviews() {
        setupButton(saveButton)
        saveButton.setBackgroundColor(color: .label, forState: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBackground, for: .normal)
        
        setupButton(editButton)
        editButton.setTitle("Edit", for: .normal)
        
        setupButton(buyButton)
    }
    
    private func setupButton(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.setDynamicFont(forTextStyle: .title3, weight: .bold)
        button.setBackgroundColor(color: .systemGreen, forState: .normal)
        button.rounded(cornerRadius: 27.5)
    }
}

extension ProductDetailActionView {
    private func configureData() {
        buyButton.setTitle("Buy | 20,000 LBP", for: .normal)
    }
}

extension ProductDetailActionView {
    private func setupConstraints() {
        saveButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        let hStack = UIStackView(arrangedSubviews: [saveButton, editButton])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .fillEqually
        hStack.spacing = 16
        
        let vStack = UIStackView(arrangedSubviews: [
            hStack,
            buyButton
        ])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 16
        vStack.alignment = .fill
        
        addSubview(vStack)
        vStack.fillSuperview()
    }
}
