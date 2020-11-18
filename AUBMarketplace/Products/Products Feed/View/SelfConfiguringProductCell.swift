//
//  SelfConfiguringCell.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

protocol SelfConfiguringProductCell {
    static var reuseIdentifier: String { get }
    func configure(with product: Product)
}
