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
