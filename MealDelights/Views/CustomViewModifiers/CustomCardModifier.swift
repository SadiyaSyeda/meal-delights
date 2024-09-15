//
//  CustomCardModifier.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import SwiftUI

struct CustomCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            .shadow(radius: 8)
            .padding(.horizontal)
    }
}

extension View {
    func customCardStyle() -> some View {
        self.modifier(CustomCardModifier())
    }
}
