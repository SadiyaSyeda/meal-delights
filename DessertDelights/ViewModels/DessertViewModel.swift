//
//  DessertViewModel.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/11/24.
//

import Foundation

@MainActor
class DessertViewModel: ObservableObject {
    @Published var meals: [Dessert] = []
    var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchMeals() async {
        do {
            let data = try await networkClient.performRequest(for: DataRequestType.dessertList)
            let decodedResponse = try JSONDecoder().decode(DessertList.self, from: data)
            
            meals = decodedResponse.meals.filter { dessert in
                return !dessert.id.isEmpty && !dessert.name.isEmpty
            }.sorted { $0.name < $1.name }
        } catch {
            print("Failed to fetch meals: \(error)")
        }
    }
}
