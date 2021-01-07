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


//MARK: - GET Requests
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
        
        // Creating URL from string
        if let url = URL(string: urlString) {
            // Creating URLSession
            let session = URLSession(configuration: .default)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            // Adding task to the session with the newly created URL along with completion handler method to handle success or failure of GET request
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    //build model by parsing JSON data and adding location string, then pass that model to the delegate
                    if let products = self.buildDataModel(data: safeData) {
                        completion(products, section)
                    }
                }
            }
            // Starting the task (it says resume() but it actually just starts it)
            task.resume()
        }
        
    }
    
    func fetchProductCategory(category: String, completion: @escaping([Product]) -> Void) {
        let token = defaults.string(forKey: "token")!
        var urlString = "\(K.url)/api/search/products/category/"
        
        let categoryMap: [String: String] = [
            "Books" : "Book",
            "Course Notes" : "Notes",
            "Supplies" : "Supplies",
            "Electronics" : "Electronics",
            "Others" : "Other"
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


//MARK: - POST Requests
extension ProductManager {
    func postProduct(_ newProduct: NewProductData, completion: @escaping () -> Void) {
        let token = defaults.string(forKey: "token")!
        let urlString = "\(K.url)/api/products"
        
        //1. Creating URL from string
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            print(String(data: buildProductData(newProduct: newProduct)!, encoding: .utf8)!)
            request.httpBody = buildProductData(newProduct: newProduct)!
            
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
                    DispatchQueue.main.async {
                        completion()
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


//MARK: - Data Building
extension ProductManager {
    private func buildProductData(newProduct: NewProductData) -> Foundation.Data? {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(newProduct)
            return encodedData
        } catch {
            print(error)
            return nil
        }
    }
}
