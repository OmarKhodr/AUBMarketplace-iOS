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
//    let searchView = Button(text: "Search", image: UIImage(systemName: "magnifyingglass")!)
    let searchView = SearchFieldView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textColor = .label
        let boldFont = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: boldFont)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        let hStackView = UIStackView(arrangedSubviews: [titleLabel, searchView])
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.spacing = 40
        hStackView.distribution = .fill
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        
        let vStackView = UIStackView(arrangedSubviews: [hStackView, separator])
        vStackView.axis = .vertical
        vStackView.spacing = 10
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: vStackView.topAnchor),
            hStackView.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
            hStackView.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),
        ])
        
        addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        searchView.startAnimatingPressActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
    }
}
