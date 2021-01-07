//
//  Service.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/23/20.
//

import UIKit

//class Service {
//    var requestorImage: UIImage =  UIImage(named: "requestor")!
//    var title: String = "EECE 230 Lab Assistant"
//    var requestor: String = "Louay Bazzi"
//    var description: String = "assist the lab instructor in teaching the Introduction to Programming using Python's lab"
//}

class Service {
    var requestorImage: UIImage?
    var title: String
    var requestor: String
    var description: String
    
    init(data: ServiceData) {
        self.requestorImage = UIImage(named: "requestor")!
        self.title = data.name
        self.requestor = "Louay Bazzi"
        self.description = data.description
    }
}
