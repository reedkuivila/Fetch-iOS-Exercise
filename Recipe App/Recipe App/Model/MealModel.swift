//
//  Meal.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//

import Foundation

struct Meal: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String?
    let strMealThumb: String
    let ingredients: [Ingredient]

    var id: String {
        return idMeal
    }
}

struct Ingredient: Decodable, Hashable {
    let name: String
    let measure: String
}

// MARK: Meal model extensions
extension Meal {
    /// Custom decoder to handle nil and empty values
    /// - Parameters:
    ///  - decoder: the JSON decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDict = try container.decode([String: String?].self)
        var index = 1
        var ingredients: [Ingredient] = []
        while let ingredient = mealDict["strIngredient\(index)"] as? String,
              let measure = mealDict["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        self.ingredients = ingredients
        idMeal = mealDict["idMeal"] as? String ?? ""
        strMeal = mealDict["strMeal"] as? String ?? ""
        strInstructions = mealDict["strInstructions"] as? String ?? ""
        strMealThumb = mealDict["strMealThumb"] as? String ?? ""
    }
}


// MARK: - Test Data Extensions
extension Meal {
    static let mealTest = Meal(
        idMeal: "12345",
        strMeal: "Dummy Meal",
        strInstructions: """
        These are dummy instructiosn for cooking
        
        How to make Chocolate Chip Cookies
        Let’s walk through how to make chocolate chip cookies step-by-step, and don’t forget to watch the video.

        Make the chocolate chip cookie dough
        The first step in making these easy chocolate chip cookies to to combine the dry ingredients in a medium size bowl.

        When doing this, make sure to Measure the flour correctly.
        Be sure to use a measuring cup made for dry ingredients (NOT a pyrex liquid measuring cup).
        Then, measure flour by scooping it into a measuring cup and leveling it with a knife.
        """,
        strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
        ingredients: [
            Ingredient(name: "Ingredient 1", measure: "200g"),
            Ingredient(name: "Ingredient 2", measure: "1 cup"),
            Ingredient(name: "Ingredient 3", measure: "2 tsp"),
            Ingredient(name: "Ingredient 4", measure: "1/2 tsp"),
            Ingredient(name: "Ingredient 5", measure: "3 cloves")
        ]
    )
}
