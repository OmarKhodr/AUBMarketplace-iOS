//
//  Product.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

struct Product: Hashable {
    let title: String
    let category: String
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
