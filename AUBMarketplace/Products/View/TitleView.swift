//
//  TitleView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class TitleView: UICollectionViewCell, SelfConfiguringProductCell {
    static let reuseIdentifier = "headerId"
    
    let titleLabel = UILabel()
    let searchView = SearchFieldView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "Products"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, searchView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 40
        stackView.distribution = .fill
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
    }
}
