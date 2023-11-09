//
//  MainView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//

//import SwiftUI
//
//struct MainView: View {
//    @StateObject var viewModel = MealViewModel()
//
//    let columns: [GridItem] = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    var body: some View {
//        NavigationStack{
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 1) {
//                    ForEach(viewModel.meals) { meal in
//                        NavigationLink(destination: MealDetailView(meal: meal)) {
//                            MealRowView(meal: meal)
//                                .frame(maxWidth: .infinity)
//                        }
//                    }
//                }
//                .padding()
//                .navigationTitle("Meals")
//            }
//            .onAppear {
//                viewModel.fetchMeals()
//            }
//        }
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MealViewModel()
    @State private var searchText = ""

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Try \"Cake\"", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

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
            .navigationTitle("Meals")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


extension MainView {
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return viewModel.meals
        } else {
            return viewModel.meals.filter { meal in
                // Customize the filter condition as needed
                meal.strMeal.localizedCaseInsensitiveContains(searchText) ||
                meal.ingredients.contains { ingredient in
                    ingredient.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
}
