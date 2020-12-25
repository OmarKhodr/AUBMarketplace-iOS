//
//  SelfConfiguringServiceCell.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/23/20.
//

import Foundation

protocol SelfConfiguringServiceCell {
    static var reuseIdentifier: String { get }
    func configure(with service: Service)
}
