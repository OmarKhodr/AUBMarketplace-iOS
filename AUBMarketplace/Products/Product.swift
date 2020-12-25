//
//  Product.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

struct Product: Hashable {
    
    enum Status {
        case available
        case saleInProgress
        case sold
    }
    
    let title: String
    let category: String
    let description: String = "Design patterns are typical solutions to commonly occurring problems in software design. You can’t just find a pattern and copy it into your program, the way you can with off-the-shelf functions or libraries. The pattern is not a specific piece of code, but a general concept for solving a particular problem. They are like pre-made blueprints that you can customize to solve a recurring design problem in your code."
    let price: Double = 0.0
    let seller: String = "Omar Khodr"
    var status: Status = .available
    
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
