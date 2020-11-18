//
//  TitleSupplementaryView.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/1/20.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    let label = UILabel()
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        
        let font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
        label.adjustsFontForContentSizeCategory = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset+10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}
