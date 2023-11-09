//
//  MealViewModel.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//

//MARK: iteration 1
import Foundation

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    let mealService = MealService()
    @Published var selectedMeal: Meal?

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


