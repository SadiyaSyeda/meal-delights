//
//  NetworkClientTests.swift
//  MealDelightsTests
//
//  Created by Sadiya Syeda on 9/14/24.
//

import XCTest
@testable import MealDelights

final class NetworkClientTests: XCTestCase {
    
    func testPerformRequestSuccess() async throws {
        let mockData = """
        {
            "categories": [
                {"idCategory": "1", "strCategory": "Beef"},
                {"idCategory": "2", "strCategory": "Chicken"}
            ]
        }
        """.data(using: .utf8)!
        
        let mockURLSession = MockURLSession(mockData: mockData, statusCode: 200, mockError: nil)
        let networkClient = NetworkClient(session: mockURLSession)
        
        let data = try await networkClient.performRequest(for: .categories)
        
        let mockCategoryList = try JSONDecoder().decode(MealCategoryList.self, from: mockData)
        let returnedCategoryList = try JSONDecoder().decode(MealCategoryList.self, from: data)
        
        for (mockCategory, returnedCategory) in zip(mockCategoryList.categories, returnedCategoryList.categories) {
            XCTAssertEqual(mockCategory.id, returnedCategory.id)
            XCTAssertEqual(mockCategory.name, returnedCategory.name)
        }
    }
    
    func testPerformRequestNon200StatusCode() async throws {
        let mockURLSession = MockURLSession(mockData: nil, statusCode: 404, mockError: nil)
        let networkClient = NetworkClient(session: mockURLSession)
        
        do {
            _ = try await networkClient.performRequest(for: .categories)
            XCTFail("Expected to throw URLError, but request succeeded")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badServerResponse)
        }
    }
    
    func testPerformRequest404() async {
        let mockURLSession = MockURLSession(mockData: Data(), statusCode: 404, mockError: nil)
        let networkClient = NetworkClient(session: mockURLSession)
        
        do {
            _ = try await networkClient.performRequest(for: .categories)
            XCTFail("Request should have failed with 404 error")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
    
    func testPerformRequestNetworkFailure() async throws {
        let mockError = URLError(.notConnectedToInternet)
        let mockURLSession = MockURLSession(mockData: nil, statusCode: 0, mockError: mockError)
        let networkClient = NetworkClient(session: mockURLSession)
        
        do {
            _ = try await networkClient.performRequest(for: .categories)
            XCTFail("Expected to throw URLError, but request succeeded")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .notConnectedToInternet)
        } catch {
            XCTFail("Expected URLError, but got \(error)")
        }
    }
    
    func testBuildRequest() throws {
        let requestType = DataRequestType.dessertList
        let requestBuilder = RequestBuilder()
        
        let request = try requestBuilder.buildRequest(for: requestType)
        
        XCTAssertEqual(request.url?.absoluteString, "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
