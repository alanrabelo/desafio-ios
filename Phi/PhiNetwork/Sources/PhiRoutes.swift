//
//  PhiRoutes.swift
//  PhiNetwork
//
//  Created by Lo on 04/03/21.
//

import Foundation

public enum PhiRoutes {
    
    private enum Methods: String {
        case get = "GET"
    }
    
    private var baseUrlString: String {
        "https://desafio-mobile-bff.herokuapp.com"
    }
    
    private var token: String {
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    }
    
    case balance
    case statement(Int, Int)
    case details(String)
    
    var method: String {
        switch self {
        case .balance:
            return Methods.get.rawValue
            
        case .details:
            return Methods.get.rawValue
        
        case .statement:
            return Methods.get.rawValue
        }
    }
    
    var params: [URLQueryItem] {
        return []
    }
    
    var header: [(String, String)] {
        return [("token", token)]
    }
    
    private var uri: String {
        switch self {
        case .balance:
            return "myBalance"
            
        case .statement(let limit, let offset):
            return "myStatement/\(limit)/\(offset)"
            
        case .details(let id):
            return "myStatement/detail/\(id)"
        }
    }
    
    private var url: URL? {
        return URL(string: self.baseUrlString)?.appendingPathComponent(self.uri)
    }
    
    var request: URLRequest? {
        
        guard let initialUrl = url else {
            return nil
        }
        
        var urlBuilder = URLComponents(url: initialUrl, resolvingAgainstBaseURL: false)
        
        if !self.params.isEmpty {
            urlBuilder?.queryItems = self.params
        }
        
        guard let url = urlBuilder?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        
        self.header.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
                
        return request
    }
}
