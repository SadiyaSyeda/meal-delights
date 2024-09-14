//
//  MealCategoriesViewModel.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import Foundation

@MainActor
class MealCategoriesViewModel: ObservableObject {
    @Published var categories: [MealCategory] = []
    var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCategories() async {
        do {
            let data = try await networkClient.performRequest(for: DataRequestType.categories)
            let decodedResponse = try JSONDecoder().decode(MealCategoryList.self, from: data)
            
            categories = decodedResponse.categories.filter { category in
                return !category.id.isEmpty && !category.name.isEmpty
            }.sorted { $0.name < $1.name }
            
        } catch {
            print("Failed to fetch categories: \(error)")
        }
    }
}
