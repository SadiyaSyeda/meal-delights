//
//  NetworkClient.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import Foundation

protocol NetworkClientProtocol {
    func performRequest(for requestType: DataRequestType) async throws -> Data
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

struct NetworkClient: NetworkClientProtocol{
    private let requestBuilder = RequestBuilder()
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func performRequest(for requestType: DataRequestType) async throws -> Data {
        let urlRequest = try requestBuilder.buildRequest(for: requestType)
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
