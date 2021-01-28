//
//  RatingStarsView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 16/01/2021.
//

import UIKit

class RatingStarsView: UIView {
    
    let rating: Float

    let ratingStars = [
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
    ]
    
    init(value rating: Float) {
        self.rating = rating
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        for i in 0..<5 {
            ratingStars[i].translatesAutoresizingMaskIntoConstraints = false
            ratingStars[i].tintColor = .label
        }
    }
    
    private func setupConstraints() {
        let starsHStack = UIStackView()
        starsHStack.translatesAutoresizingMaskIntoConstraints = false
        for star in ratingStars {
            starsHStack.addArrangedSubview(star)
        }
        starsHStack.distribution = .fillProportionally
        starsHStack.alignment = .top
        starsHStack.spacing = 2
        
        addSubview(starsHStack)
        
        starsHStack.fillSuperview()
    }
    
    private func configureData() {
        let starSize: CGFloat = 13
        
        for i in 0..<Int(rating) {
            ratingStars[i].image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: starSize))
        }
        
        if Int(rating) < 5 {
            ratingStars[Int(rating)].image = UIImage(systemName: (rating == floorf(rating) ?
                                                                "star.fill" : "star.leadinghalf.fill"), withConfiguration: UIImage.SymbolConfiguration(pointSize: starSize))
        }
        
        for i in Int(rating)+1..<5 {
            ratingStars[i].image = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: starSize))
        }
    }

}
