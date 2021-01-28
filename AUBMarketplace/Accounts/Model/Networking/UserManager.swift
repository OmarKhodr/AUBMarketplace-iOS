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
    
}


//MARK: - GET Requests
extension UserManager {
    
    func signIn(email: String, password: String, completion: @escaping (UserToken) -> Void) {
        let urlString = "\(K.url)/api/auth"
        let json = [
            "email": email,
            "password": password
        ]
        
        guard let url = URL(string: urlString) else {
            fatalError("URL invalid!!!")
        }
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            if let error = error {
    
                print(error)
                return
                
            } else {
            
                if let safeData = data, let userToken = self.buildToken(data: safeData) {
                    DispatchQueue.main.async {
                        completion(userToken)
                    }
                }
                
            }
            
        }
        task.resume()
    }
    
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
    
    func fetchUser(id: String, completion: @escaping (User) -> Void) {
        
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


//MARK: - POST Requests
extension UserManager {
    func createUser(info: UserInfo, completion: @escaping (UserToken) -> Void) {
        let token = defaults.string(forKey: "token")!
        let urlString = "\(K.url)/api/users"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = buildUserData(info: info)!
            
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8)!)
                    if let token = self.buildToken(data: safeData) {
                        DispatchQueue.main.async {
                            completion(token)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func buildUserData(info: UserInfo) -> Foundation.Data? {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(info)
            return encodedData
        } catch {
            print(error)
            return nil
        }
    }
    
    private func buildToken(data: Foundation.Data) -> UserToken? {
        let decoder = JSONDecoder()
        do {
            let token = try decoder.decode(UserToken.self, from: data)
            return token
        } catch {
            print("Failed to build token: \(error)")
            return nil
        }
    }
    
}
