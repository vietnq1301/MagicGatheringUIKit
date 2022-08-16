//
//  API.swift
//  MagicGathering
//
//  Created by Nguyễn Việt on 24/06/2022.
//

import Foundation

enum APIError: Error {
    case error(message: String)
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
            
        }
    }
}



struct APIService {
    
    public static let shared = APIService()
    
    func GET<T: Decodable>(endPoint: Endpoint) async throws -> (T, Int) {
        guard let url = endPoint.url else {
            throw APIError.error(message: "Invalid URL")
        }
        print(url)
        let data = try await URLSession.shared.data(url: url)
        let decodeData = try JSONDecoder().decode(T.self, from: data.0)
        return (decodeData, data.1)
    }
    
    func GET<T: Decodable>(endPoint: Endpoint, cachePolicy: NSURLRequest.CachePolicy) async throws -> T {
        guard let url = endPoint.url else {
            throw APIError.error(message: "Invalid URL")
        }
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10.0)
        let data = try await URLSession.shared.data(urlRequest: request)
        let decodeData = try JSONDecoder().decode(T.self, from: data)
        return decodeData
    }
}






