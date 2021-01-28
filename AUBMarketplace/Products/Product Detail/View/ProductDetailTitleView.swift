//
//  ProductDetailTitleView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 21/01/2021.
//

import UIKit

class ProductDetailTitleView: UIView {
    
    let product: Product
    
    let categoryImageView = UIImageView()
    let titleLabel = UILabel()
    var smallProfileView: SmallProfileView!
    
    init(with product: Product) {
        self.product = product
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.tintColor = .label
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setDynamicFont(forTextStyle: .title1, weight: .bold)
        titleLabel.numberOfLines = 4
        
        smallProfileView = SmallProfileView(with: nil)
        smallProfileView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureData() {
        categoryImageView.image = UIImage(systemName: K.productCategorySymbol[product.category]!, withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        
        titleLabel.text = product.title
        
        let user = User(data: UserData(name: "Omar Khodr",
                                       email: "ohk04@mail.aub.edu",
                                       number: 123,
                                       major: "CSE"))
        smallProfileView.user = user
        smallProfileView.configureData()
        
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            categoryImageView,
            titleLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        
        addSubview(stackView)
        addSubview(smallProfileView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            smallProfileView.topAnchor.constraint(equalTo: topAnchor),
            smallProfileView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: smallProfileView.leadingAnchor, constant: -20),
            
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            smallProfileView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ])
    }
}
