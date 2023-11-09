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

// extension to handle the nil/null values for various properties
extension Meal {
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
        }//: while
            self.ingredients = ingredients
            idMeal = mealDict["idMeal"] as? String ?? ""
            strMeal = mealDict["strMeal"] as? String ?? ""
            strInstructions = mealDict["strInstructions"] as? String ?? ""
            strMealThumb = mealDict["strMealThumb"] as? String ?? ""
        print("DEBUG: Meal \(self.strMeal)'s Fetched Ingredients: \(self.ingredients)")

        }//: init
    }//: extension-Meals

extension Meal {
    static let mealTest = Meal(idMeal: "1", strMeal: "Apam balik", strInstructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.", strMealThumb:  "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", ingredients: Meal.ingredientTest ?? [])
}

extension Meal {
    static let ingredientTest: [Ingredient]?  =
    [
        Ingredient(name: "Milk", measure: "200ml"),
        Ingredient(name: "Oil", measure: "60ml"),
        Ingredient(name: "Eggs", measure: "2"),
        Ingredient(name: "Flour", measure: "1600g"),
        Ingredient(name: "Baking Powder", measure: "3 tsp"),
        Ingredient(name: "Salt", measure: "1/2 tsp"),
        Ingredient(name: "Unsalted Butter", measure: "25g"),
        Ingredient(name: "Sugar", measure: "45g"),
        Ingredient(name: "Peanut Butter", measure: "3 tbs")
    ]
}
extension Meal {
    static let dummyMeal: Meal = Meal(
        idMeal: "12345",
        strMeal: "Dummy Meal",
        strInstructions: """
        This is a dummy meal. Follow these instructions to prepare it:

        1. Gather the following ingredients:
           - Ingredient 1: 200g
           - Ingredient 2: 1 cup
           - Ingredient 3: 2 tsp
           - Ingredient 4: 1/2 tsp
           - Ingredient 5: 3 cloves

        2. Instructions:
           - Step 1: Combine Ingredient 1 and Ingredient 2 in a bowl.
           - Step 2: Add Ingredient 3 and mix well.
           - Step 3: Sprinkle Ingredient 4 over the mixture.
           - Step 4: Crush Ingredient 5 and sprinkle it over the mixture.

        3. Enjoy your delicious Dummy Meal!
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
