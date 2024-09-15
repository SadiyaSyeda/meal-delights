//
//  DessertDetailsView.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import SwiftUI

struct DessertDetailsView: View {
    let mealID: String
    @StateObject private var viewModel = DessertDetailsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                if let detail = viewModel.selectedDessertDetail {
                    Text(detail.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.leading, 16)
                    
                    // Instructions Section
                    Text("Instructions")
                        .customTitleStyle()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(detail.instructions)
                            .font(.body)
                    }
                    .customCardStyle()
                    
                    // Ingredients Section
                    Text("Ingredients & Measurements")
                        .customTitleStyle()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(detail.formattedIngredients, id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.body)
                        }
                    }
                    .customCardStyle()
                } else {
                    ProgressView("Loading details...")
                }
            }
            .padding(.top, 5)
            .padding(.leading, 5)
            .padding(.trailing, 5)
            .task {
                await viewModel.fetchMealDetails(by: mealID)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

// Preview
struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDetail = DessertDetails(
            name: "Cheesecake",
            instructions: "1. Mix ingredients.\n2. Bake in oven.\n3. Enjoy your cheesecake!",
            strIngredient1: "Cheese",
            strIngredient2: "Sugar",
            strIngredient3: "Butter",
            strMeasure1: "200g",
            strMeasure2: "100g",
            strMeasure3: "50g"
        )
        
        let viewModel = DessertDetailsViewModel()
        viewModel.selectedDessertDetail = mockDetail
        
        return DessertDetailsView(mealID: "52894")
            .environmentObject(viewModel)
    }
}
