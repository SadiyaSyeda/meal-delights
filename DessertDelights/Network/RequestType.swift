//
//  RequestType.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import Foundation

protocol RequestType {
    var baseDomain: BaseDomain { get }
    var endpoint: String { get }
    var httpMethod: HttpMethodType { get }
}

enum DataRequestType: RequestType {
    case categories
    case dessertList
    case dessertDetails(id: String)
    
    var baseDomain: BaseDomain {
        switch self {
        case .categories, .dessertList, .dessertDetails:
            return .mealdb
        }
    }
    
    var endpoint: String {
        switch self {
        case .categories:
            return "api/json/v1/1/categories.php"
        case .dessertList:
            return "api/json/v1/1/filter.php?c=Dessert"
        case .dessertDetails(let id):
            return "api/json/v1/1/lookup.php?i=\(id)"
        }
    }
    
    var httpMethod: HttpMethodType {
        switch self {
        case .categories, .dessertList, .dessertDetails:
            return .get
        default: // Incase if there will be a new endpoint with POST method in future
            return .post
        }
    }
    
    var bodyData: Data? {
        switch self {
        default:
            return nil
        }
    }
}
