//
//  CategoryTableCell.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/12/20.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringProductCell {
    static let reuseIdentifier: String = "SmallTableCell"

    let name = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true

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
        let title = product.title
        name.text = title
        
        switch title {
        case "Books":
            imageView.image = UIImage(systemName: "book.closed.fill")
            imageView.tintColor = .label
        case "Course Notes":
            imageView.image = UIImage(systemName: "note.text")
            imageView.tintColor = .label
        default:
            imageView.image = UIImage(systemName: "ruler.fill")
            imageView.tintColor = .label
            
        }
    }

    required init?(coder: NSCoder) {
        fatalError("How many times do I have to tell you? THIS. ISN'T. SUPPORTED.")
    }
}
