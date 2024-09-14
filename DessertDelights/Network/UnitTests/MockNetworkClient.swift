//
//  MockNetworkClient.swift
//  DessertDelightsTests
//
//  Created by Sadiya Syeda on 9/14/24.
//

import Foundation

class MockNetworkClient: NetworkClientProtocol {
    var mockData: Data?
    var mockError: Error?
    
    init(mockData: Data? = nil, mockError: Error? = nil) {
        self.mockData = mockData
        self.mockError = mockError
    }
    
    func performRequest(for requestType: DataRequestType) async throws -> Data {
        if let error = mockError {
            throw error
        }
        
        if let data = mockData {
            return data
        }
        
        return Data()
    }
}
