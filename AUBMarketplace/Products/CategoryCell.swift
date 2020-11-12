//
//  CategoryTableCell.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/12/20.
//

import UIKit

class CategoryTableCell: UICollectionViewCell, SelfConfiguringProductCell {
    static let reuseIdentifier: String = "SmallTableCell"

    let name = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label

        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .systemGray5
//        imageView.layer.cornerRadius = 5
//        imageView.clipsToBounds = true

        let stackView = UIStackView(arrangedSubviews: [imageView, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with product: Product) {
        name.text = product.title
    }

    required init?(coder: NSCoder) {
        fatalError("How many times do I have to tell you? THIS. ISN'T. SUPPORTED.")
    }
}
