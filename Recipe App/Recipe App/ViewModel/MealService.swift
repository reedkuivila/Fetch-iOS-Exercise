//
//  MealService.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//

import Foundation

class MealService {
    
    // fetch the meal
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
                let result = try JSONDecoder().decode([String: [Meal]].self, from: data)
                if let meals = result["meals"] {
                    completion(meals)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // use the mealID to find the instructions for specific meal
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
                let result = try JSONDecoder().decode([String: [Meal]].self, from: data)
                if let meals = result["meals"], let firstMeal = meals.first, let instructions = firstMeal.strInstructions {
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
                let result = try JSONDecoder().decode([String: [Meal]].self, from: data)
                if let meals = result["meals"], let firstMeal = meals.first {
                    completion(firstMeal)
                } else {
                    completion(nil)
                }
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
