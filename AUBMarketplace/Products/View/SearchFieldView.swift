//
//  SearchFieldView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class SearchFieldView: UIControl {
    
    let searchSymbol = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        
        searchSymbol.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        searchSymbol.tintColor = .secondaryLabel
        searchSymbol.contentMode = .scaleAspectFit
        
        addSubview(searchSymbol)
        searchSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchSymbol.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
