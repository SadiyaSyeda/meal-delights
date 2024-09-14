//
//  MealCategoriesListView.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import SwiftUI

struct MealCategoriesListView: View {
    @StateObject private var viewModel = MealCategoriesViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.categories) { category in
                    NavigationLink(
                        destination: category.name == "Dessert" ? AnyView(DessertsListView()) : AnyView(Text("Details coming soon !!!").foregroundColor(.red))
                    ) {
                        HStack {
                            AsyncImageView(urlString: category.thumbnail)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 100, height: 100)
                            
                            Text(category.name)
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
        .navigationTitle("Meal Categories 🍔🌮")
        .task {
            await viewModel.fetchCategories()
        }
    }
}

// Preview
struct MealCategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCategories = [
            MealCategory(id: "1", name: "Dessert", thumbnail: ""),
            MealCategory(id: "2", name: "Pasta", thumbnail: ""),
            MealCategory(id: "3", name: "Seafood", thumbnail: "")
        ]
        
        let viewModel = MealCategoriesViewModel()
        viewModel.categories = mockCategories
        
        return NavigationStack {
            MealCategoriesListView()
                .environmentObject(viewModel)
        }
    }
}
