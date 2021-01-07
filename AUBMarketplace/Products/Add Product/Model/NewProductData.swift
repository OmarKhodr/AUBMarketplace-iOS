//
//  NewProductData.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/7/21.
//

import Foundation

struct NewProductData: Encodable {
    let name: String
    let category: String
    let description: String
    let majors: [String]
    let price: Int
}

/*
 {
     "name": "EECE 437 Test Book",
     "category": "Book",
     "description": "This is a test book we are testing right nowww",
     "majors": ["CSE", "CCE", "Graphic Design", "CS"],
     "price": 20000
 }
 */
