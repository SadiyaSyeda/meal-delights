//
//  MealCategoriesViewModelTests.swift
//  DessertDelightsTests
//
//  Created by Sadiya Syeda on 9/14/24.
//

import XCTest
@testable import DessertDelights

@MainActor
class MealCategoriesViewModelTests: XCTestCase {
    var viewModel: MealCategoriesViewModel!
    var mockNetworkClient: MockNetworkClient!
    let mockCategoryData: Data = """
        {
            "categories": [
                {
                    "idCategory": "1",
                    "strCategory": "Appetizer",
                    "strCategoryThumb": "https://www.example.com/mock_image.jpg"
                },
                {
                    "idCategory": "2",
                    "strCategory": "Dessert",
                    "strCategoryThumb": "https://www.example.com/mock_image2.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient(mockData: mockCategoryData)
        viewModel = MealCategoriesViewModel(networkClient: mockNetworkClient)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    func testFetchCategoriesSuccess() async {
        let mockCategoryData = """
        {
            "categories": [
                {"idCategory": "1", "strCategory": "Appetizer", "strCategoryThumb": "url1"},
                {"idCategory": "2", "strCategory": "Dessert", "strCategoryThumb": "url2"}
            ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        await viewModel.fetchCategories()
        
        XCTAssertEqual(viewModel.categories.count, 2)
        XCTAssertEqual(viewModel.categories[0].name, "Appetizer")
        XCTAssertEqual(viewModel.categories[1].name, "Dessert")
    }
    
    func testFetchCategoriesEmptyResponse() async {
        let mockCategoryData = """
        {
            "categories": []
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        await viewModel.fetchCategories()
        
        XCTAssertTrue(viewModel.categories.isEmpty)
    }
    
    func testFetchCategoriesInvalidData() async {
        let mockCategoryData = """
        {
            "invalidKey": []
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        await viewModel.fetchCategories()
        
        XCTAssertTrue(viewModel.categories.isEmpty)
    }
    
    func testFetchCategoriesNetworkError() async {
        mockNetworkClient.mockError = URLError(.notConnectedToInternet)
        
        await viewModel.fetchCategories()
        
        XCTAssertTrue(viewModel.categories.isEmpty)
    }
    
    func testFetchCategoriesDataParsingError() async {
        let mockCategoryData = """
        {
            "categories": [
                {"id": "1", "name": "Appetizer"} // Missing "thumbnail" key
            ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        await viewModel.fetchCategories()
        
        XCTAssertTrue(viewModel.categories.isEmpty)
    }
    
    func testFetchCategoriesFiltering() async {
        let mockCategoryData = """
        {
            "categories": [
                {"idCategory": "", "strCategory": "Appetizer", "strCategorythumbnail": "url1"},
                {"idCategory": "2", "strCategory": "", "strCategorythumbnail": "url2"},
                {"idCategory": "3", "strCategory": "Dessert", "strCategorythumbnail": "url3"}
            ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        await viewModel.fetchCategories()
        
        XCTAssertEqual(viewModel.categories.count, 1)
        XCTAssertEqual(viewModel.categories[0].name, "Dessert")
    }
    
    func testFetchCategoriesSorting() async {
        let mockCategoryData = """
        {
            "categories": [
                {"idCategory": "2", "strCategory": "Appetizer", "strCategorythumbnail": "url1"},
                {"idCategory": "1", "strCategory": "Dessert", "strCategorythumbnail": "url2"}
            ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        await viewModel.fetchCategories()
        
        XCTAssertEqual(viewModel.categories[0].name, "Appetizer")
        XCTAssertEqual(viewModel.categories[1].name, "Dessert")
    }
    
    func testFetchCategoriesDependencyInjection() async {
        let mockCategoryData = """
        {
            "categories": [
                {"idCategory": "1", "strCategory": "Appetizer", "strCategorythumbnail": "url1"}
            ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.mockData = mockCategoryData
        
        let viewModel = MealCategoriesViewModel(networkClient: mockNetworkClient)
        
        await viewModel.fetchCategories()
        
        XCTAssertEqual(viewModel.categories.count, 1)
        XCTAssertEqual(viewModel.categories[0].name, "Appetizer")
    }
}
