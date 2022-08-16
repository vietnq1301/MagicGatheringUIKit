//
//  URLSession+Ext.swift
//  MagicGathering
//
//  Created by Nguyễn Việt on 07/07/2022.
//

import Foundation

extension URLSession {
    func data(url: URL) async throws -> (Data, Int) {
        try await withCheckedThrowingContinuation({ c in
            dataTask(with: url) { data, response, error in
                if let httpRespone = response as? HTTPURLResponse {
                    print(httpRespone.statusCode)
                }
                
                if let error = error {
                    c.resume(throwing: APIError.error(message: error.localizedDescription))
                } else {
                    if let data = data {
                        let httpRespone = response as! HTTPURLResponse
                        c.resume(returning: (data, httpRespone.statusCode))
                    } else {
                        c.resume(throwing: APIError.error(message: "Bad response"))
                    }
                }
            }.resume()
        })
    }
    
    func data(urlRequest: URLRequest)  async throws -> Data {
        try await withCheckedThrowingContinuation({ c in
            dataTask(with: urlRequest) { data, response, error in
                if let httpRespone = response as? HTTPURLResponse {
                    print(httpRespone.statusCode)
                }
                
                if let error = error {
                    c.resume(throwing: APIError.error(message: error.localizedDescription))
                } else {
                    if let data = data {
                        c.resume(returning: data)
                    } else {
                        c.resume(throwing: APIError.error(message: "Bad response"))
                    }
                }
            }.resume()
        })
    }
}
