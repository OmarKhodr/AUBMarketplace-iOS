//
//  ProfileView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/6/21.
//

import UIKit

class ProfileInfoView: UIView {

    let profilePictureView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let numberLabel = UILabel()
    
    let ratingStars = [
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
    ]
    let ratingLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Subviews + Model Data
extension ProfileInfoView {
    private func setupSubviews() {
        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        profilePictureView.image = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        profilePictureView.contentMode = .scaleAspectFit
        profilePictureView.tintColor = .systemGreen
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name"
        nameLabel.setDynamicFont(forTextStyle: .title2, weight: .medium)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email"
        emailLabel.textColor = .secondaryLabel
        emailLabel.setDynamicFont(forTextStyle: .body)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.text = "Phone Number"
        numberLabel.textColor = .secondaryLabel
        numberLabel.setDynamicFont(forTextStyle: .body)
        
        for i in 0..<5 {
            ratingStars[i].translatesAutoresizingMaskIntoConstraints = false
            ratingStars[i].image = UIImage(systemName: "star")
            ratingStars[i].contentMode = .scaleAspectFit
            ratingStars[i].tintColor = .systemYellow
        }
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "Rating"
        ratingLabel.textColor = .secondaryLabel
        ratingLabel.setDynamicFont(forTextStyle: .body)
    }
    
    func configureData(with user: User) {
        
        profilePictureView.image = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        nameLabel.text = user.name
        emailLabel.text = user.email
        numberLabel.text = user.number
        
        let rating = user.rating
        for i in 0..<Int(rating) {
            ratingStars[i].image = UIImage(systemName: "star.fill")
        }
        
        if Int(rating) < 5 {
            ratingStars[Int(rating)].image = UIImage(systemName: (rating == floorf(rating) ?
                                                                "star.fill" : "star.leadinghalf.fill"))
        }
        
        for i in Int(rating)+1..<5 {
            ratingStars[i].image = UIImage(systemName: "star")
        }
        
        ratingLabel.text = "Rating: \(user.rating)"
    }
}

//MARK: - Constraints
extension ProfileInfoView {
    private func setupConstraints() {
        profilePictureView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profilePictureView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        let starsHStack = UIStackView()
        starsHStack.translatesAutoresizingMaskIntoConstraints = false
        for star in ratingStars {
            starsHStack.addArrangedSubview(star)
        }
        starsHStack.distribution = .fillProportionally
        starsHStack.alignment = .top
        starsHStack.spacing = 2
        
        let infoVStack = UIStackView(arrangedSubviews: [
            nameLabel,
            emailLabel,
            numberLabel,
            ratingLabel,
            starsHStack
        ])
        infoVStack.translatesAutoresizingMaskIntoConstraints = false
        infoVStack.axis = .vertical
        infoVStack.distribution = .fill
        infoVStack.alignment = .center
        infoVStack.spacing = 3
        
        let HStack = UIStackView(arrangedSubviews: [profilePictureView, infoVStack])
        HStack.translatesAutoresizingMaskIntoConstraints = false
        HStack.axis = .vertical
        HStack.distribution = .fillProportionally
        HStack.alignment = .center
        HStack.spacing = 8
        
        addSubview(HStack)
        HStack.fillSuperview()
    }
}
