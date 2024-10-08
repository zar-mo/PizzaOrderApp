//
//  APIClient.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import Foundation

protocol NetworkClient: AnyObject {
    func fetchData<T: APIRequest>(_ request: T) async throws -> T.Response
}

class APIClient: NetworkClient {
    
    let apiEndpoint: URL?
    
    init(apiEndpoint: URL?) {
        self.apiEndpoint = apiEndpoint
    }
    
    func fetchData<T>(_ request: T) async throws -> T.Response where T: APIRequest {
        guard let apiEndpoint = apiEndpoint else {
            throw APIClientError.apiEndpointInvalid
        }
        
        let urlRequest = try request.with(baseUrl: apiEndpoint)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIClientError.invalidStatusCode
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy =  .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.Response.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
    enum APIClientError: Error {
        case apiEndpointInvalid
        case invalidStatusCode
    }
}







