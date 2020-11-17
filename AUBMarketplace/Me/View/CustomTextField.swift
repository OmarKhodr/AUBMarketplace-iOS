//
//  CustomTextField.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/16/20.
//

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        borderStyle = .roundedRect
        backgroundColor = .systemGray6
        rounded(cornerRadius: 8.0)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
