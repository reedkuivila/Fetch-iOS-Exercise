//
//  MealViewModel.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMeal: Meal?
    let mealService = MealService()
    
    /// Fetch meals from the MealService file
    func fetchMeals() {
        mealService.fetchMeals { fetchedMeals in
            if let fetchedMeals = fetchedMeals {
                DispatchQueue.main.async {
                    self.meals = fetchedMeals
                }
            }
        }
    }
}


