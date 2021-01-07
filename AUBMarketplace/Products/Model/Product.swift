//
//  Product.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import UIKit

class Product: Hashable {
    
    enum Status: String {
        case available = "Available"
        case saleInProgress = "Pending"
        case sold = "Sold"
    }
    
    let isCategory: Bool
    
    let id: String
    let title: String
    let category: String
    var description: String?
    var price: Int?
    let currency: String
    let seller: String = "Omar Khodr"
    var status: Status
    var imageUrls: [String]
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    init(data: ProductData) {
        self.isCategory = false
        self.id = data._id
        self.title = data.name
        self.category = data.category
        self.description = data.description
        self.price = data.price
        self.currency = data.currency
        self.status = Status(rawValue: data.status)!
        self.imageUrls = data.images
        
//        for urlString in data.images {
//            ProductImageManager.shared.fetch(urlString) { (image) in
//                print("\(data.name): \(urlString)")
//                self.images.append(image)
//            }
//        }
    }
    
    init(title: String) {
        self.isCategory = true
        self.id = ""
        self.title = title
        self.category = ""
        self.price = 0
        self.currency = ""
        self.status = .available
        self.imageUrls = []
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
