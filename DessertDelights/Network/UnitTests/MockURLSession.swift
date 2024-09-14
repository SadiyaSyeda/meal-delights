//
//  MockURLSession.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/14/24.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var statusCode: Int
    let mockError: Error?
    
    init(mockData: Data?, statusCode: Int, mockError: Error?) {
        self.mockData = mockData
        self.statusCode = statusCode
        self.mockError = mockError
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil)!
        
        if !(200...299).contains(statusCode) {
            throw URLError(.badServerResponse)
        }
        
        if let data = mockData {
            return (data, response)
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

