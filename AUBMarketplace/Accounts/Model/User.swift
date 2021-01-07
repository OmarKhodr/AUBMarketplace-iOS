//
//  User.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import Foundation

class User {
    let name: String
    let email: String
    let number: String
    let major: String
    let rating: Float
    
    init(data: UserData) {
        self.name = data.name
        self.email = data.email
        self.number = "(+961) 70 123 4567"
        self.major = data.major
        self.rating = 4.6
    }
}
