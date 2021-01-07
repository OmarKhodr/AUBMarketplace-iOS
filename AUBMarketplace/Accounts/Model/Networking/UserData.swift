//
//  UserData.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/7/21.
//

import Foundation

struct UserData: Decodable {
    let name: String
    let email: String
    let number: Int
    let major: String
}
