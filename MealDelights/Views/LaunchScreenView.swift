//
//  LaunchScreenView.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/13/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                Text("Meal Delights")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}
