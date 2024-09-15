//
//  RequestBuilder.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import Foundation

struct RequestBuilder {
    
    func buildRequest(for requestType: RequestType) throws -> URLRequest {
        guard let url = URL(string: requestType.baseDomain.getMealDBDomain() + "/" + requestType.endpoint) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.httpMethod.getHttpMethod()
        
        // If there is body data (e.g., POST), set it to the request
        if let requestType = requestType as? DataRequestType, let body = requestType.bodyData {
            urlRequest.httpBody = body
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
}
