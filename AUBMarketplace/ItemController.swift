//
//  HomeController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/1/20.
//

import Foundation

class ItemController {
    
    struct Item: Hashable {
        let title: String
        let category: String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct ItemCollection: Hashable {
        let title: String
        let items: [Item]
        
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    var collections: [ItemCollection] {
        return _collections
    }
    
    init() {
        generateCollections()
    }
    fileprivate var _collections =  [ItemCollection]()
    
}

extension ItemController {
    func generateCollections() {
        _collections = [
            ItemCollection(title: "For You", items: [
                Item(title: "Dive Into Design Patterns - Alexander Shvets", category: "Books"),
                Item(title: "Casio fx-991EX (Scientific)", category: "Supplies"),
                Item(title: "EECE 332 Notes", category: "Course Notes"),
                Item(title: "Introduction to Algorithms (CLRS)", category: "Books")
            ])
        ]
    }
}
