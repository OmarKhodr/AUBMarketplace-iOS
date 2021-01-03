//
//  Product.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

class Product: Hashable {
    
    enum Status {
        case available
        case saleInProgress
        case sold
    }
    
    let isCategory: Bool
    
    let title: String
    let category: String
    var description: String?
    var price: Int?
    let currency: String
    let seller: String = "Omar Khodr"
    let status: Status = .available
    var imageUrls: [String]
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    init(data: ProductData) {
        self.isCategory = false
        self.title = data.name
        self.category = data.category
        self.description = data.description
        self.price = data.price
        self.currency = data.currency
        self.imageUrls = data.images
    }
    
    init(title: String) {
        self.isCategory = true
        self.title = title
        self.category = ""
        self.price = 0
        self.currency = ""
        self.imageUrls = []
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
