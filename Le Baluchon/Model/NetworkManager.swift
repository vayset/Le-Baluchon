//
//  NetworkManager.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 12/11/2020.
//

import Foundation


protocol NetworkManagerProtocol {
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
}



class NetworkManager: NetworkManagerProtocol {
    
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)  {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidHttpStatusCode))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let decoddedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecodeJSON))
                return
            }
            
            completion(.success(decoddedData))
            return
        }
        
        task.resume()
    }
    
}
