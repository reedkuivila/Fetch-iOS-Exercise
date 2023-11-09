//
//  MealService.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//
//

import Foundation

class MealService {
    
    // MARK: - Fetch Meals
    
    /// Fetches dessert meals.
    ///
    /// - Parameters:
    ///   - completion: A closure that will be called with an array of Meal objects on success or nil on failure.
    func fetchMeals(completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MealResponse.self, from: data)
                completion(result.meals)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - Fetch Instructions
    
    /// Fetches instructions for a specific meal by its ID.
    ///
    /// - Parameters:
    ///   - mealID: The ID of the meal.
    ///   - completion: A closure that will be called with the instructions string on success or nil on failure.
    func fetchInstructions(forMealWithID mealID: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MealResponse.self, from: data)
                if let firstMeal = result.meals?.first, let instructions = firstMeal.strInstructions {
                    completion(instructions)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - Fetch Detailed Meal
    
    /// Fetches detailed information for a meal by its ID.
    ///
    /// - Parameters:
    ///   - idMeal: The ID of the meal.
    ///   - completion: A closure that will be called with a Meal object on success or nil on failure.
    func fetchDetailedMeal(idMeal: String, completion: @escaping (Meal?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let result = try JSONDecoder().decode(MealResponse.self, from: data)
                completion(result.meals?.first)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

struct MealResponse: Decodable {
    let meals: [Meal]?
}
