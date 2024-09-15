//
//  DesertViewModelTests.swift
//  MealDelightsTests
//
//  Created by Sadiya Syeda on 9/13/24.
//

import XCTest
@testable import MealDelights

@MainActor
class DessertViewModelTests: XCTestCase {
    var viewModel: DessertViewModel!
    var mockNetworkClient: MockNetworkClient!
    let mockData: Data = """
    {
        "meals": [
            {
                "idMeal": "12345",
                "strMeal": "Mock Dessert",
                "strMealThumb": "https://www.example.com/mock_image.jpg"
            },
            {
                "idMeal": "67890",
                "strMeal": "Another Mock Dessert",
                "strMealThumb": "https://www.example.com/mock_image2.jpg"
            }
        ]
    }
    """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient(mockData: mockData)
        viewModel = DessertViewModel(networkClient: mockNetworkClient)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    func testFetchMealsSuccess() async {
        let mockDessertListData = """
        {
            "meals": [
                {"idMeal": "1", "strMeal": "Cheesecake"},
                {"idMeal": "2", "strMeal": "Brownie"}
            ]
        }
        """.data(using: .utf8)!
        
        mockNetworkClient.mockData = mockDessertListData
        
        await viewModel.fetchMeals()
        
        XCTAssertEqual(viewModel.meals.count, 2)
        XCTAssertEqual(viewModel.meals[0].name, "Brownie")
        XCTAssertEqual(viewModel.meals[1].name, "Cheesecake")
    }
    
    func testFetchMealsNetworkFailure() async {
        mockNetworkClient.mockError = URLError(.notConnectedToInternet)
        
        await viewModel.fetchMeals()
        
        XCTAssertTrue(viewModel.meals.isEmpty)
    }
    
    func testFetchMealsInvalidData() async {
        let invalidData = "Invalid JSON".data(using: .utf8)!
        mockNetworkClient.mockData = invalidData
        
        await viewModel.fetchMeals()
        
        XCTAssertTrue(viewModel.meals.isEmpty)
    }
    
    func testFetchMealsEmptyList() async {
        let emptyDessertListData = """
        {
            "meals": []
        }
        """.data(using: .utf8)!
        
        mockNetworkClient.mockData = emptyDessertListData
        
        await viewModel.fetchMeals()
        
        XCTAssertTrue(viewModel.meals.isEmpty)
    }
    
    func testFetchMealsWithInvalidMeals() async {
        let mockDessertListData = """
        {
            "meals": [
                {"idMeal": "1", "strMeal": "Cheesecake"},
                {"idMeal": "", "strMeal": "Brownie"},
                {"idMeal": "3", "strMeal": ""}
            ]
        }
        """.data(using: .utf8)!
        
        mockNetworkClient.mockData = mockDessertListData
        
        await viewModel.fetchMeals()
        
        XCTAssertEqual(viewModel.meals.count, 1)
        XCTAssertEqual(viewModel.meals[0].name, "Cheesecake")
    }
    
    func testFetchMealsSortedAlphabetically() async {
        let mockDessertListData = """
        {
            "meals": [
                {"idMeal": "1", "strMeal": "Brownie"},
                {"idMeal": "2", "strMeal": "Cheesecake"}
            ]
        }
        """.data(using: .utf8)!
        
        mockNetworkClient.mockData = mockDessertListData
        
        await viewModel.fetchMeals()
        
        XCTAssertEqual(viewModel.meals.count, 2)
        XCTAssertEqual(viewModel.meals[0].name, "Brownie")
        XCTAssertEqual(viewModel.meals[1].name, "Cheesecake")
    }
}
