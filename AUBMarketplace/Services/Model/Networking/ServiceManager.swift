//
//  ServiceManager.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import Foundation

class ServiceManager {
    
    private init() { }
    public static let shared = ServiceManager()
    let defaults = UserDefaults.standard
    
}

//MARK: - Services Feed
extension ServiceManager {
    func fetchFeedServices(completion: @escaping ([Service]) -> Void) {
        let token = defaults.string(forKey: "token")!
        let urlString = "\(K.url)/api/recommend/services"

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
                    if let services = self.buildDataModel(data: safeData) {
                        DispatchQueue.main.async {
                            completion(services)
                        }
                    }
                }
            }
            //4. Starting the task (it says resume() but it actually just starts it)
            task.resume()
        }
    }
    
    private func buildDataModel(data: Foundation.Data) -> [Service]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ServicesData.self, from: data)
            var services: [Service] = []
            for serviceData in decodedData.data {
                services.append(Service(data: serviceData))
            }
            return services
        } catch {
            print(error)
            return nil
        }
    }
    
    private func buildArrayModel(data: Foundation.Data) -> [Service]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ServiceData].self, from: data)
            var services: [Service] = []
            for serviceData in decodedData{
                services.append(Service(data: serviceData))
            }
            return services
        } catch {
            print(error)
            return nil
        }
    }
}
