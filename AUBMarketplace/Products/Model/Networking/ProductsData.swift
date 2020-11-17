//
//  ProductsData.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/12/20.
//

import Foundation

struct ProductsData: Decodable {
    
    let data: [ProductData]
    
}

struct ProductData: Decodable {
    let name: String
    let category: String
}
