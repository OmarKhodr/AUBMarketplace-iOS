//
//  ServiceCell.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/23/20.
//

import UIKit

class ServiceCell: UITableViewCell {
    static var reuseIdentifier = "serviceCell"
    
    let requestorProfilePic = UIImageView()
    let titleLabel = UILabel()
    let requestorLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ServiceCell {
    private func setupViews() {
        requestorProfilePic.translatesAutoresizingMaskIntoConstraints = false
        requestorProfilePic.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.setDynamicFont(forTextStyle: .body, weight: .medium)
        
        requestorLabel.translatesAutoresizingMaskIntoConstraints = false
        requestorLabel.textColor = .label
        requestorLabel.numberOfLines = 1
        requestorLabel.setDynamicFont(forTextStyle: .subheadline)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 2
        descriptionLabel.setDynamicFont(forTextStyle: .footnote)
    }
    
    private func setupConstraints() {
        requestorProfilePic.heightAnchor.constraint(equalToConstant: 50).isActive = true
        requestorProfilePic.widthAnchor.constraint(equalToConstant: 50).isActive = true
        requestorProfilePic.rounded(cornerRadius: 25)
        
        let vStack = UIStackView(arrangedSubviews: [
            titleLabel,
            requestorLabel,
            descriptionLabel
        ])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.spacing = 3
        
        let hStack = UIStackView(arrangedSubviews: [requestorProfilePic, vStack])
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .top
        hStack.spacing = 8
        
        contentView.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}

extension ServiceCell: SelfConfiguringServiceCell {
    func configure(with service: Service) {
        requestorProfilePic.image = service.requestorImage
        titleLabel.text = service.title
        requestorLabel.text = service.requestor
        descriptionLabel.text = service.description
    }
}
