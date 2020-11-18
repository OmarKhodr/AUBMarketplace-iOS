//
//  ProductDescriptionView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/18/20.
//

import UIKit

class ProductDescriptionView: UIView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    init(with product: Product) {
        super.init(frame: .zero)
        
        configure(with: product)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductDescriptionView {
    private func setupViews() {
        titleLabel.text = "Description"
        titleLabel.textColor = .label
        titleLabel.setDynamicFont(forTextStyle: .title3, weight: .bold)
        
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
}

extension ProductDescriptionView {
    func configure(with product: Product) {
        descriptionLabel.text = product.description
    }
}
