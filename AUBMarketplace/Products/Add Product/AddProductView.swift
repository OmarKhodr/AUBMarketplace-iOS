//
//  AddProductView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import UIKit

class AddProductView: UIView {
    
    let titleTextField = BoldBorderlessTextField(placeholder: "title")
    
    let currencyListButton = ListButton(title: "Currency")
    let priceTextField = BoldBorderlessTextField(placeholder: "Price")
    
    let categoryListButton = ListButton(title: "Category")
    
    let imagesLabel = UILabel()
    let images = UIView() // TODO
    
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subviews Setup
extension AddProductView {
    private func setupSubviews() {
        
        
        
    }
}
