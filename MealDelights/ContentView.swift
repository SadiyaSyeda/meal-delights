//
//  ContentView.swift
//  MealDelights
//
//  Created by Sadiya Syeda on 9/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showLaunchScreen = true
    
    var body: some View {
        Group {
            if showLaunchScreen {
                LaunchScreenView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                NavigationStack {
                    MealCategoriesListView()
                }
            }
        }
    }
}

