//
//  SmallProfileView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/13/21.
//

import UIKit

class SmallProfileView: UIView {

    let user: User
    
    let profilePicView = UIImageView()
    let nameLabel = UILabel()
    let ratingStars = [
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
    ]
    
    init(with user: User) {
        self.user = user
        super.init(frame: .zero)
        setupSubviews()
//        configureData()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SmallProfileView {
    private func setupSubviews() {
        
    }
}
