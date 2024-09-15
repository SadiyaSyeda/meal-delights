//
//  BaseDomain.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/14/24.
//

import Foundation

enum BaseDomain {
    case mealdb
    
    func getMealDBDomain() -> String {
        switch self {
        case .mealdb:
            return "https://www.themealdb.com"
        }
    }
}
