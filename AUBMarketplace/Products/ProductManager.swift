//
//  ProductManager.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/12/20.
//

import Foundation

class ProductManager {
    
    var delegate: ProductManagerDelegate?
    let defaults = UserDefaults.standard
    
    func fetchRecommended() {
        let tokenString = defaults.string(forKey: "token")!
        let url = "http://localhost:5000/api/posts/product/recommended"
        performRequest(with: url, token: tokenString, type: .foryou)
    }
    
    func fetchHottest() {
        let tokenString = defaults.string(forKey: "token")!
        let url = "http://localhost:5000/api/posts/product/hottest"
        performRequest(with: url, token: tokenString, type: .hottest)
    }
    
    func fetchRecentlyViewed() {
        let tokenString = defaults.string(forKey: "token")!
        let url = "http://localhost:5000/api/posts/product/latest"
        performRequest(with: url, token: tokenString, type: .recent)
    }
    
    private func performRequest(with urlString: String, token: String, type: ProductSectionCategory) {
        //1. Creating URL from string
        if let url = URL(string: urlString) {
            //2. Creating URLSession
            let session = URLSession(configuration: .default)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(token, forHTTPHeaderField: "x-auth-token")
            
            //3. Adding task to the session with the newly created URL along with completion handler method to handle success or failure of GET request
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(self, error: error)
                    return
                }
                if let safeData = data {
                    //build model by parsing JSON data and adding location string, then pass that model to the delegate
                    if let products = self.buildModel(data: safeData) {
                        switch type {
                        case .foryou:
                            self.delegate?.didFetchRecommendedProducts(self, products: products)
                        case .hottest:
                            self.delegate?.didFetchHottestProducts(self, products: products)
                        default:
                            self.delegate?.didFetchRecentProducts(self, products: products)
                        }
                        
                    }
                    
                }
            }
            //4. Starting the task (it says resume() but it actually just starts it)
            task.resume()
        }
    }
    
    private func buildModel(data: Foundation.Data) -> [Product]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductsData.self, from: data)
            var products: [Product] = []
            for prodData in decodedData.data {
                products.append(Product(title: prodData.name, category: prodData.category))
            }
            return products
        } catch {
            print(error)
            return nil
        }
    }
}
