//
//  MealsCategoryModel.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/12/24.
//

import Foundation

struct MealCategory: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
    }
}

struct MealCategoryList: Decodable {
    let categories: [MealCategory]
}
