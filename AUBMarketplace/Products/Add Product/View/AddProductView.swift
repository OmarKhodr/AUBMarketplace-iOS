//
//  AddProductView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import UIKit

class AddProductView: UIView {
    
    let titleTextField = BoldBorderlessTextField(placeholder: "Title")
    
    let currencyListButton = ListButton(title: "Currency")
    let priceTextField = BoldBorderlessTextField(placeholder: "Price")
    
    let categoryListButton = ListButton(title: "Category")
    
    let imagesLabel = UILabel() // TODO
    let images = UIView() // TODO
    
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
    
    let currencyAction: () -> Void
    let categoryAction: () -> Void
    
    init(currencyAction: @escaping() -> Void, categoryAction: @escaping() -> Void) {
        self.currencyAction = currencyAction
        self.categoryAction = categoryAction
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subviews
extension AddProductView {
    private func setupSubviews() {
        currencyListButton.titleLabel.text = "Currency"
        
        categoryListButton.titleLabel.text = "Category"
        
        priceTextField.setupForPriceContent()
        
        descriptionLabel.text = "Description"
        descriptionLabel.setDynamicFont(forTextStyle: .title2, weight: .bold)
        
        descriptionTextView.frame = CGRect(x: 0.0, y: 0.0, width: Double(bounds.width), height: 200.0)
        descriptionTextView.backgroundColor = .red
        descriptionTextView.autocapitalizationType = .sentences
    }
}


//MARK: - Constraints
extension AddProductView {
    private func setupConstraints() {
        let priceHStack = UIStackView(arrangedSubviews: [currencyListButton, priceTextField])
        priceHStack.distribution = .fillProportionally
        priceHStack.spacing = 16
        
        let stackView = UIStackView(arrangedSubviews: [
            titleTextField,
            priceHStack,
            categoryListButton,
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 20
        
        addSubview(stackView)
        
        stackView.fillSuperview()
    }
}


//MARK: - Targets
extension AddProductView {
    private func setupTargets() {
        currencyListButton.addTarget(self, action: #selector(didTapCurrency), for: .touchUpInside)
        categoryListButton.addTarget(self, action: #selector(didTapCategory), for: .touchUpInside)
    }
    
    @objc private func didTapCurrency() {
        currencyAction()
    }
    
    @objc private func didTapCategory() {
        categoryAction()
    }
}
