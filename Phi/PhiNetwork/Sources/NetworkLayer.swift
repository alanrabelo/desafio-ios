//
//  NetworkLayer.swift
//  PhiNetwork
//
//  Created by Lo on 04/03/21.
//

import Foundation

public enum NetworkError: Error {
    case invalidRequest
    case noResponse
    case invalidStatusCode(statusCode: Int)
    case noData
    case errorParsing(dataString: String)
}

public final class NetworkLayer {
    public static let shared = NetworkLayer()
    
    public func perform<T:Decodable>(route: PhiRoutes, completion: @escaping (Result<T, Error>)->Void) {
        
        guard let request = route.request else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noResponse))
                return
            }
            
            guard 200..<299 ~= response.statusCode else {
                completion(.failure(NetworkError.invalidStatusCode(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                let convertedString = String(data: data, encoding: .utf8) ?? "Can't convert into String"
                completion(.failure(NetworkError.errorParsing(dataString: convertedString)))
            }
        }.resume()
    }
}
