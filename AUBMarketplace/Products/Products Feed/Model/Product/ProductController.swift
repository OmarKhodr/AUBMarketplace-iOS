//
//  HomeController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/1/20.
//

import Foundation

class ProductController {
    
    init() {
        generateCollections()
//        generateCategories()
    }
    var collections =  [ProductCollection]()
    
}

extension ProductController {
    func generateCollections() {
        collections = [
            ProductCollection(title: "Title", sectionType: .title, products: [
                Product(title: "Products", category: "")
            ]),
            ProductCollection(title: "For You", sectionType: .foryou, products: [
                Product(title: "Dive Into Design Patterns - Alexander Shvets", category: "Books"),
                Product(title: "Casio fx-991EX (Scientific)", category: "Supplies"),
                Product(title: "EECE 332 Notes", category: "Course Notes"),
                Product(title: "Introduction to Algorithms (CLRS)", category: "Books")
            ]),
            ProductCollection(title: "Hottest", sectionType: .hottest, products: [
                Product(title: "Dive Into Design Patterns - Alexander Shvets", category: "Books"),
                Product(title: "Casio fx-991EX (Scientific)", category: "Supplies"),
                Product(title: "EECE 332 Notes", category: "Course Notes"),
                Product(title: "Introduction to Algorithms (CLRS)", category: "Books")
            ]),
            ProductCollection(title: "Categories", sectionType: .categories, products: [
                Product(title: "Books", category: ""),
                Product(title: "Course Notes", category: ""),
                Product(title: "Supplies", category: "")
            ]),
            ProductCollection(title: "Recently Viewed", sectionType: .recent, products: [
                Product(title: "Dive Into Design Patterns - Alexander Shvets", category: "Books"),
                Product(title: "Casio fx-991EX (Scientific)", category: "Supplies"),
                Product(title: "EECE 332 Notes", category: "Course Notes"),
                Product(title: "Introduction to Algorithms (CLRS)", category: "Books")
            ])
        ]
    }
    
    func generateCategories() {
        collections = [
            ProductCollection(title: "Categories", sectionType: .categories, products: [
                Product(title: "Books", category: ""),
                Product(title: "Course Notes", category: ""),
                Product(title: "Supplies", category: "")
            ])
        ]
    }
}
