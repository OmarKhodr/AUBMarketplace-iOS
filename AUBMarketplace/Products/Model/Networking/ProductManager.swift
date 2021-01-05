//
//  ProductManager.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/12/20.
//

import Foundation

class ProductManager {
    
    private init() { }
    static let shared = ProductManager()
    let defaults = UserDefaults.standard
    
}


//MARK: - Network Calls
extension ProductManager {
    func fetchFeedProducts(section: ProductSection,
                           completion: @escaping ([Product], ProductSection) -> Void) {
        let token = defaults.string(forKey: "token")!
        var urlString = "\(K.url)/api/recommend/products"
        
        if section == .hottest {
            urlString += "/hottest"
        } else if section == .recent {
            urlString += "/latest"
        }
        
        //1. Creating URL from string
        if let url = URL(string: urlString) {
            //2. Creating URLSession
            let session = URLSession(configuration: .default)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            //3. Adding task to the session with the newly created URL along with completion handler method to handle success or failure of GET request
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
//                    print(String(data: safeData, encoding: .utf8)!)
                    //build model by parsing JSON data and adding location string, then pass that model to the delegate
                    if let products = self.buildDataModel(data: safeData) {
                        completion(products, section)
                    }
                }
            }
            //4. Starting the task (it says resume() but it actually just starts it)
            task.resume()
        }
    }
    
    func fetchProductCategory(category: String, completion: @escaping([Product]) -> Void) {
        let token = defaults.string(forKey: "token")!
        var urlString = "\(K.url)/api/search/products/category/"
        
        let categoryMap: [String: String] = [
            "Books" : "Book"
        ]
        
        urlString += categoryMap[category]!
        
        //1. Creating URL from string
        if let url = URL(string: urlString) {
            //2. Creating URLSession
            let session = URLSession(configuration: .default)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            //3. Adding task to the session with the newly created URL along with completion handler method to handle success or failure of GET request
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8)!)
                    //build model by parsing JSON data and adding location string, then pass that model to the delegate
                    if let products = self.buildArrayModel(data: safeData) {
                        completion(products)
                    }
                }
            }
            //4. Starting the task (it says resume() but it actually just starts it)
            task.resume()
        }
    }
    
    func fetchProductQuery(query: String, completion: @escaping([Product]) -> Void) {
        print("query: \(query)")
        let token = defaults.string(forKey: "token")!
        let urlString = "\(K.url)/api/search/products"
        
        //1. Creating URL from string
        if var components = URLComponents(string: urlString) {
            components.queryItems = [
                URLQueryItem(name: "query", value: query)
            ]
            
            print(components.url!)
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            //2. Creating URLSession
            let session = URLSession(configuration: .default)
            
            //3. Adding task to the session with the newly created URL along with completion handler method to handle success or failure of GET request
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8)!)
                    //build model by parsing JSON data and adding location string, then pass that model to the delegate
                    if let products = self.buildArrayModel(data: safeData) {
                        completion(products)
                    }
                }
            }
            //4. Starting the task (it says resume() but it actually just starts it)
            task.resume()
        }
    }
}


//MARK: - Model Building
extension ProductManager {
    private func buildDataModel(data: Foundation.Data) -> [Product]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductsData.self, from: data)
            var products: [Product] = []
            for prodData in decodedData.data {
                products.append(Product(data: prodData))
            }
            return products
        } catch {
            print(error)
            return nil
        }
    }
    
    private func buildArrayModel(data: Foundation.Data) -> [Product]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ProductData].self, from: data)
            var products: [Product] = []
            for prodData in decodedData {
                products.append(Product(data: prodData))
            }
            return products
        } catch {
            print(error)
            return nil
        }
    }
    
}
