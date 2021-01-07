//
//  ServicesData.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import Foundation

struct ServicesData: Decodable {
    let data: [ServiceData]
}

struct ServiceData: Decodable {
    let name: String
    let category: String
    let description: String
    let salary: Int
    let status: String
    let owner: String
}
