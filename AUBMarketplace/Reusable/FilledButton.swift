//
//  FilledButton.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/28/20.
//

import UIKit

class FilledButton: UIButton {

    init(textColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        setTitle("Button", for: .normal)
        titleLabel?.setDynamicFont(forTextStyle: .body, weight: .medium)
        setTitleColor(textColor, for: .normal)
        setBackgroundColor(color: backgroundColor, forState: .normal)
        rounded(cornerRadius: 8)
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
