//
//  ProfilePictureView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/13/21.
//

import UIKit

class ProfilePictureView: UIView {

    let user: User
    
    let profilePictureView = UIImageView()
    let typeLabel = UILabel()
    let typeBackgroundView = UIView()
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        setupSubviews()
        configureData()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        profilePictureView.image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        profilePictureView.tintColor = .label
        profilePictureView.contentMode = .scaleAspectFit
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.textColor = .systemBackground
        typeLabel.setDynamicFont(forTextStyle: .caption1, weight: .bold)
        
        typeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureData() {
        let color: UIColor = user.type == .student ? .systemRed : .systemBlue
        
        profilePictureView.layer.borderColor = color.cgColor
        profilePictureView.layer.borderWidth = 7.0
        profilePictureView.rounded(cornerRadius: profilePictureView.bounds.height/2)
        
        typeLabel.text = user.type.rawValue
        
        typeBackgroundView.backgroundColor = color
    }
    
    private func setupConstraints() {
        typeBackgroundView.addSubview(typeLabel)
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: typeBackgroundView.topAnchor, constant: 5),
            typeLabel.leadingAnchor.constraint(equalTo: typeBackgroundView.leadingAnchor, constant: 5),
            typeLabel.bottomAnchor.constraint(equalTo: typeBackgroundView.bottomAnchor, constant: -5),
            typeLabel.trailingAnchor.constraint(equalTo: typeBackgroundView.trailingAnchor, constant: -5)
        ])
        
        addSubview(typeBackgroundView)
        addSubview(profilePictureView)
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
