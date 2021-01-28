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
        setupConstraints()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        profilePictureView.image = UIImage(systemName: "person.crop.circle.fill")
        profilePictureView.tintColor = .label
        profilePictureView.contentMode = .scaleAspectFit
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.textColor = .systemBackground
        typeLabel.setDynamicFont(forTextStyle: .caption1, font: .boldSystemFont(ofSize: 10))
        
        typeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        typeBackgroundView.addSubview(typeLabel)
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: typeBackgroundView.topAnchor, constant: 5),
            typeLabel.leadingAnchor.constraint(equalTo: typeBackgroundView.leadingAnchor, constant: 5),
            typeLabel.bottomAnchor.constraint(equalTo: typeBackgroundView.bottomAnchor, constant: -5),
            typeLabel.trailingAnchor.constraint(equalTo: typeBackgroundView.trailingAnchor, constant: -5)
        ])
        
        addSubview(profilePictureView)
        addSubview(typeBackgroundView)
        
        
        NSLayoutConstraint.activate([
            typeBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            typeBackgroundView.centerXAnchor.constraint(equalTo: profilePictureView.centerXAnchor),
            
            profilePictureView.heightAnchor.constraint(equalToConstant: 70),
            profilePictureView.widthAnchor.constraint(equalToConstant: 70),
            profilePictureView.topAnchor.constraint(equalTo: typeBackgroundView.topAnchor, constant: 5),
            profilePictureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profilePictureView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profilePictureView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureData() {
        let color: UIColor = user.type == .student ? .systemRed : .systemBlue
        
        profilePictureView.layer.borderColor = color.cgColor
        profilePictureView.layer.borderWidth = 5.0
        print("picture height: \(profilePictureView.bounds.height)")
        profilePictureView.rounded(cornerRadius: 35)
        
        typeLabel.text = user.type.rawValue
        
        typeBackgroundView.backgroundColor = color
        typeBackgroundView.rounded(cornerRadius: 5)
    }
}
