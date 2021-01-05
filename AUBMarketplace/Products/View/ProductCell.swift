//
//  ProductCell.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/1/20.
//

import UIKit

class ProductCell: UICollectionViewCell, SelfConfiguringProductCell {
    
    static let reuseIdentifier = "product-cell"
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupViews()
//        setupLayout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category
        
//        if let firstUrlString = product.imageUrls.first, let firstUrl = NSURL(string: firstUrlString) {
//            ProductImageCache.publicCache.load(url: firstUrl, product: product) { (product, image) in
//                if let image = image {
//                    print("\(product.title): \(firstUrlString)")
//                    self.imageView.image = image
//                }
//            }
//        }
    }
    
}

extension ProductCell {
    
//    func setupViews() {
//        titleLabel.font = .preferredFont(forTextStyle: .caption1)
//        titleLabel.adjustsFontForContentSizeCategory = true
//        
//        categoryLabel.font = .preferredFont(forTextStyle: .caption2)
//        categoryLabel.adjustsFontForContentSizeCategory = true
//        categoryLabel.textColor = .placeholderText
//        
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.layer.borderWidth = 1
//        imageView.layer.cornerRadius = 4
//        imageView.backgroundColor = UIColor(named: "green")
//    }
//    
//    func setupLayout() {
//        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, categoryLabel])
//        stackView.distribution = .fill
//        stackView.axis = .vertical
//        stackView.alignment = .leading
//        stackView.setCustomSpacing(10, after: imageView)
//        stackView.backgroundColor = .systemBlue
//        
//        contentView.addSubview(stackView)
//        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.anchor(top: contentView.topAnchor,
//                         leading: contentView.leadingAnchor,
//                         bottom: contentView.bottomAnchor,
//                         trailing: contentView.trailingAnchor)
//    }
    
    func setup() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)

        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true

        categoryLabel.textColor = .secondaryLabel
        categoryLabel.font = .preferredFont(forTextStyle: .body)
        categoryLabel.adjustsFontForContentSizeCategory = true

        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .systemGray5

        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
}
