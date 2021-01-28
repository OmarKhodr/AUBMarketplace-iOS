//
//  SmallProfileView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/13/21.
//

import UIKit

class SmallProfileView: UIView {

    var user: User?
    
    var profilePicView: ProfilePictureView!
    let nameLabel = UILabel()
    var ratingStarsView: RatingStarsView!
    
    init(with user: User?) {
        self.user = user
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setDynamicFont(forTextStyle: .body)
    }
    
    // Called when parent view controller fetches the user and sets the 'user' property
    public func configureData() {
        nameLabel.text = user!.name
        
        profilePicView = ProfilePictureView(user: user!)
        profilePicView.translatesAutoresizingMaskIntoConstraints = false
        
        ratingStarsView = RatingStarsView(value: user!.rating)
        ratingStarsView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            profilePicView,
            nameLabel,
            ratingStarsView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.setCustomSpacing(2, after: nameLabel)
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
}
