//
//  DessertDetailsViewModelTests.swift
//  DessertDelightsTests
//
//  Created by Sadiya Syeda on 9/14/24.
//

import XCTest
@testable import DessertDelights

@MainActor
class DessertDetailsViewModelTests: XCTestCase {
    var viewModel: DessertDetailsViewModel!
    var mockNetworkClient: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkClient = MockNetworkClient()
        
        viewModel = DessertDetailsViewModel(networkClient: mockNetworkClient)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkClient = nil
        
        super.tearDown()
    }
    
    func testFetchMealDetailsSuccess() async {
        let mockDessertDetailData = """
        {
            "meals": [
                {
                    "idMeal": "1",
                    "strMeal": "Cheesecake",
                    "strInstructions": "Mix ingredients and bake.",
                    "strIngredient1": "Cheese",
                    "strMeasure1": "200g"
                }
            ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockDessertDetailData
        
        await viewModel.fetchMealDetails(by: "1")
        
        XCTAssertNotNil(viewModel.selectedDessertDetail)
        XCTAssertEqual(viewModel.selectedDessertDetail?.name, "Cheesecake")
        XCTAssertEqual(viewModel.selectedDessertDetail?.instructions, "Mix ingredients and bake.")
    }
    
    func testFetchMealDetailsNoDetailsFound() async {
        let mockEmptyDetailsData = """
        {
            "meals": []
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockEmptyDetailsData
        
        await viewModel.fetchMealDetails(by: "1")
        
        XCTAssertNil(viewModel.selectedDessertDetail)
    }
    
    func testFetchMealDetailsInvalidData() async {
        let invalidData = """
        {
            "invalidField": "value"
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = invalidData
        
        await viewModel.fetchMealDetails(by: "1")
        
        XCTAssertNil(viewModel.selectedDessertDetail)
    }
    
    func testFetchMealDetailsNetworkFailure() async {
        mockNetworkClient.mockError = URLError(.notConnectedToInternet)
        
        await viewModel.fetchMealDetails(by: "1")
        
        XCTAssertNil(viewModel.selectedDessertDetail)
    }
    
    func testFetchMealDetailsUnexpectedResponse() async {
        let unexpectedResponseData = """
        {
            "unexpectedField": "value"
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = unexpectedResponseData
        
        await viewModel.fetchMealDetails(by: "1")
        
        XCTAssertNil(viewModel.selectedDessertDetail)
    }
    
    func testFetchMealDetailsDifferentIDs() async {
        let mockDessertDetailData1 = """
        {
            "meals": [
                {"idMeal": "1", "strMeal": "Cheesecake", "strInstructions": "Mix ingredients and bake."}
            ]
        }
        """.data(using: .utf8)!
        let mockDessertDetailData2 = """
        {
            "meals": [
                {"idMeal": "2", "strMeal": "Brownie", "strInstructions": "Mix ingredients and bake."}
            ]
        }
        """.data(using: .utf8)!
        
        mockNetworkClient.mockData = mockDessertDetailData1
        await viewModel.fetchMealDetails(by: "1")
        
        XCTAssertEqual(viewModel.selectedDessertDetail?.name, "Cheesecake")
        
        mockNetworkClient.mockData = mockDessertDetailData2
        await viewModel.fetchMealDetails(by: "2")
        
        XCTAssertEqual(viewModel.selectedDessertDetail?.name, "Brownie")
    }
}
