//
//  LargeProductView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class LargeProductView: UIView {

    let imageView = UIImageView()
    let nameLabel = UILabel()
    let sellerButton = UIButton()
    
    let detailButton = UIButton()
    let buyButton = UIButton()
    let wishlistButton = UIButton()
    
    init(with product: Product) {
        super.init(frame: .zero)
        
        configure(with: product)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LargeProductView {
    private func setupViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bookcover")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.label.cgColor
        imageView.layer.shadowOpacity = 0.65
        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        imageView.layer.shadowRadius = 20
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setDynamicFont(forTextStyle: .title3, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        sellerButton.translatesAutoresizingMaskIntoConstraints = false
        sellerButton.titleLabel?.setDynamicFont(forTextStyle: .body)
        sellerButton.setTitleColor(.label, for: .normal)
        sellerButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        sellerButton.tintColor = .secondaryLabel
        sellerButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        sellerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -205)
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.tintColor = .systemGreen
        detailButton.setImage(UIImage(systemName: "ellipsis.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.setTitle("BUY | $19.99", for: .normal)
        buyButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .bold)
        buyButton.setBackgroundColor(color: .systemGreen, forState: .normal)
        buyButton.rounded(cornerRadius: 25)
        
        wishlistButton.translatesAutoresizingMaskIntoConstraints = false
        wishlistButton.setTitle("WISHLIST", for: .normal)
        wishlistButton.titleLabel?.setDynamicFont(forTextStyle: .body, weight: .bold)
        wishlistButton.setTitleColor(.label, for: .normal)
        wishlistButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        wishlistButton.tintColor = .label
        wishlistButton.setBackgroundColor(color: .systemBackground, forState: .normal)
        wishlistButton.layer.borderWidth = 2
        wishlistButton.layer.borderColor = UIColor.label.cgColor
        wishlistButton.rounded(cornerRadius: 25)
        
    }
    
    private func setupConstraints() {
        buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        wishlistButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buttonsView = UIView()
        let buttonStackView = UIStackView(arrangedSubviews: [buyButton, wishlistButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.alignment = .fill
        
        buttonsView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsView.addSubview(detailButton)
        
        NSLayoutConstraint.activate([
            detailButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            detailButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: detailButton.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor)
        ])
        
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, sellerButton, buttonsView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.setCustomSpacing(30, after: imageView)
        stackView.setCustomSpacing(20, after: sellerButton)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 400).isActive = true
        
        stackView.fillSuperview()
    }
    
    private func setupActions() {
        detailButton.startAnimatingPressActions()
        buyButton.startAnimatingPressActions()
        wishlistButton.startAnimatingPressActions()
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.title
        sellerButton.setTitle(product.seller, for: .normal)
        
    }
}
