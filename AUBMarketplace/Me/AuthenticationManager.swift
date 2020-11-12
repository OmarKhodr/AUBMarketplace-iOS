//
//  AuthenticationManager.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

class AuthenticationManager {
    
    var delegate: AuthenticationManagerDelegate?
    
    func authenticate(email: String, password: String) {
        let urlString = "http://localhost:5000/api/auth"
        let json = [
            "email": email,
            "password": password
        ]
        performAuthenticationnRequest(with: urlString, body: json)
    }
    
    func performAuthenticationnRequest(with urlString: String, body json: [String: String]) {
        // creating URL from string
        guard let url = URL(string: urlString) else {
            fatalError("URL invalid!!!")
        }
        
        // creating a URLSession that handles the POST call
        let session = URLSession(configuration: .default)
        
        // creating a URLRequest to define the call method, headers and body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        // Adding task to the session with the newly created URL along with completion handler method
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            if let error = error {
    
                self.delegate?.didFailAuthenticationWithError(self, error: error)
                
            } else {
            
                if let safeData = data, let userToken = self.buildToken(data: safeData) {
                    self.delegate?.didAuthenticate(self, token: userToken.token)
                }
                
            }
            
        }
        task.resume()
        
        
    }
    
    func buildToken(data: Foundation.Data) -> UserToken? {
        let decoder = JSONDecoder()
        do {
            let token = try decoder.decode(UserToken.self, from: data)
            return token
        } catch {
            print("Failed to build token: \(error)")
            delegate?.didFailAuthenticationWithError(self, error: error)
            return nil
        }
    }
    
}
