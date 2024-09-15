//
//  DessertModel.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/11/24.
//

import Foundation

struct Dessert: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct DessertList: Decodable {
    let meals: [Dessert]
}
