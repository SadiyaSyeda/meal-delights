//
//  DessertDetailsViewModel.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/11/24.
//

import Foundation

@MainActor
class DessertDetailsViewModel: ObservableObject {
    @Published var selectedDessertDetail: DessertDetails?
    
    public var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchMealDetails(by id: String) async {
        do {
            let data = try await networkClient.performRequest(for: DataRequestType.dessertDetails(id: id))
            let decodedResponse = try JSONDecoder().decode(DessertDetailResponse.self, from: data)
            
            if let meals = decodedResponse.meals, let mealDetail = meals.first {
                selectedDessertDetail = mealDetail
            } else {
                print("No meal details found.")
            }
            
        } catch {
            print("Failed to fetch meal details: \(error)")
        }
    }
}
