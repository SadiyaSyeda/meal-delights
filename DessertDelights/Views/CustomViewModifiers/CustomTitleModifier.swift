//
//  CustomTitleModifier.swift
//  DessertDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import SwiftUI

struct CustomTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.top)
            .padding(.leading, 16)
            .foregroundColor(.brown)
    }
}

extension View {
    func customTitleStyle() -> some View {
        self.modifier(CustomTitleModifier())
    }
}
