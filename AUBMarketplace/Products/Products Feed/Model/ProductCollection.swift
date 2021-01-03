//
//  ProductCollection.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

struct ProductCollection: Hashable {
    
    let title: String
    let sectionType: ProductSection
    let products: [Product]
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
