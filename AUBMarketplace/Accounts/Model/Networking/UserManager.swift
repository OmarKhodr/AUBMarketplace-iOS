//
//  UserManager.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/7/21.
//

import Foundation

class UserManager {
    
    private init() { }
    public static let shared = UserManager()
    private let defaults = UserDefaults.standard
    
    func fetchCurrentUser(completion: @escaping (User) -> Void) {
        let token = defaults.string(forKey: "token")!
        let urlString = "\(K.url)/api/auth"
        
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
                    print(String(data: safeData, encoding: .utf8)!)
                    if let user = self.buildModel(data: safeData) {
                        DispatchQueue.main.async {
                            completion(user)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchUser(with id: String, completion: @escaping (User) -> Void) {
        
    }
    
    private func buildModel(data: Foundation.Data) -> User? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UserData.self, from: data)
            return User(data: decodedData)
        } catch {
            print(error)
            return nil
        }
    }
    
}
