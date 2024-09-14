//
//  DessertsListView.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import SwiftUI

struct DessertsListView: View {
    @StateObject private var viewModel = DessertViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(
                        destination: DessertDetailsView(mealID: meal.id)) {
                            HStack {
                                AsyncImageView(urlString: meal.thumbnail)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Text(meal.name)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.purple)
                            }
                            .padding(.vertical, 5)
                        }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Desserts 🍰🍪🍩")
        .task {
            await viewModel.fetchMeals()
        }
        .padding(.top, 5)
    }
}

// Preview
struct DessertsListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDesserts = [
            Dessert(id: "1", name: "Cheesecake", thumbnail: ""),
            Dessert(id: "2", name: "Brownie", thumbnail: ""),
            Dessert(id: "3", name: "Ice Cream", thumbnail: "")
        ]
        
        let viewModel = DessertViewModel()
        viewModel.meals = mockDesserts
        
        return NavigationStack {
            DessertsListView()
                .environmentObject(viewModel)
        }
    }
}
