//
//  ProductManagerDelegate.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/12/20.
//

import Foundation

protocol ProductManagerDelegate {
    func didFailWithError(_ manager: ProductManager, error: Error)
    func didFetchRecommendedProducts(_ manager: ProductManager, products: [Product])
    func didFetchHottestProducts(_ manager: ProductManager, products: [Product])
    func didFetchRecentProducts(_ manager: ProductManager, products: [Product])
}
