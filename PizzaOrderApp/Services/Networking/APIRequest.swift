//
//  APIRequest.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Codable

    static var acceptableStatusCodes: Set<Int> { get }

    var path: String { get }
    var method: String { get }
    var body: Data? { get }
}

// default values
extension APIRequest {
    var method: String { return "GET" }
    var body: Data? { return nil }
    static var acceptableStatusCodes: Set<Int> { return Set([200]) }
}

enum APIRequestError: Error, LocalizedError {
    case pathEncodingFailed(String),
         urlBuildFailed

    var errorDescription: String? {
        switch self {
        case .pathEncodingFailed(let path):
            return "Failed to add percent escapes to path \(path)"
        case .urlBuildFailed:
            return "Failed to build url"
        }
    }
}

extension APIRequest {
    func with(baseUrl url: URL) throws -> URLRequest {
        
        print(url.absoluteString)

        guard let escapedPath =
            path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)
        else {
            throw APIRequestError.pathEncodingFailed(path)
        }

        var components = URLComponents()
        components.scheme = url.scheme
        components.host = url.host
        components.port = url.port
        components.percentEncodedPath = String(format: "/%@", escapedPath)
        components.path = url.path.appending(components.path)

        guard let requestUrl = components.url else { throw APIRequestError.urlBuildFailed }

        var request = URLRequest(url: requestUrl)

        request.httpMethod = method
        request.httpBody = body
        

        return request
    }
}

struct FoodRequest: APIRequest{
    
    typealias Response = FoodWrapper
    var path: String
    
}

struct FoodWrapper: Codable {
    let foodGroups: [FoodGroup]
}



