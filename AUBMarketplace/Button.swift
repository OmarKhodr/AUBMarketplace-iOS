//
//  Button.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/18/20.
//

import UIKit

class Button: UIControl {
    
    enum ImagePosition {
        case left
        case right
    }

    let label = UILabel()
    let imageView = UIImageView()
    let stackView = UIStackView()
    
    init(text: String, image: UIImage, imagePosition: ImagePosition = .left) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        
        label.text = text
        label.textColor = .white
        label.setDynamicFont(forTextStyle: .body, weight: .bold)
        
        imageView.image = image.withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(label)
        stackView.insertArrangedSubview(imageView, at: imagePosition == .left ? 0 : 1)
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
