//
//  ProductImageManager.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/6/21.
//

import UIKit

class ProductImageManager {
    
    private init() { }
    public static let shared = ProductImageManager()
    private let defaults = UserDefaults.standard
    
    func fetch(_ urlString: String, completion: @escaping (UIImage) -> Void) {
        let token = defaults.string(forKey: "token")!
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    if let image = UIImage(data: safeData) {
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
