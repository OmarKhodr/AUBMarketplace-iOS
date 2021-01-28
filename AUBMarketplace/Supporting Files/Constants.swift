//
//  Constants.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/15/20.
//

import Foundation

struct K {
    static let url = "http://localhost:5000"
//    static let url = "http://192.168.0.105:5000"
    
    // ‘Book’, ‘Notes’, ‘Supplies’, ‘Electronics’, ‘Other’’
    static let productCategorySymbol: [String: String] = [
        "Book" : "book.fill",
        "Notes" : "note.text",
        "Supplies" : "ruler.fill",
        "Electronics" : "desktopcomputer",
        "Other" : "bag.fill"
    ]
    
    static func URLify(_ data: String) -> String {
        var result: String = ""
        for char in data {
            if char != " " {
                result.append(char)
            } else {
                result.append("%20")
            }
        }
        return result
    }
}
