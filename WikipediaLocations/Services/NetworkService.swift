//
//  NetworkService.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import Foundation

class NetworkService {
    
    func executeRequest(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }

        task.resume()
    }
    
}
