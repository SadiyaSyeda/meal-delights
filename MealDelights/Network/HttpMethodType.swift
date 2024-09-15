//
//  HttpMethodType.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import Foundation

enum HttpMethodType {
    case get
    case post
    
    func getHttpMethod() -> String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
