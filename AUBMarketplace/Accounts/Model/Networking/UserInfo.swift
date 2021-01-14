//
//  UserInfo.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/7/21.
//

import Foundation

struct UserInfo: Encodable {
    let name: String
    let email: String
    let major: String
    let number: String
    let interests: [String]
    let password: String
}
