//
//  MainView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MealViewModel()
    @State private var searchText = ""
    @State private var headerHidden = false

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack {

                // Page title & search bar
                MainHeaderView(text: $searchText)

                // Scrollable grid of meals
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 1) {
                        ForEach(filteredMeals) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal)) {
                                MealRowView(meal: meal)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.fetchMeals()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// MARK: MainView Extensions
extension MainView {
    /// Filtered meals based on search text
    /// NB this only filters by the meals name (strMeal)
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return viewModel.meals
        } else {
            return viewModel.meals.filter { meal in
                meal.strMeal.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
