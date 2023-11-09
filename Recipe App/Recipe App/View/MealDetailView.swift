//
//  MealDetailView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//
//


import SwiftUI
import UIKit

struct MealDetailView: View {
    @State private var instructions: String = "Loading instructions..."
    @State private var isInstructionsExpanded = true
    @State private var isIngredientsExpanded = true
    @State private var ingredients: [Ingredient] = []
    @State private var backgroundColor: Color = .white
    let meal: Meal
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Dessert image & view background
                    mealDetailImageView
                    // Dessert ingredients
                    ingredientsList
                    // Dessert baking instructions
                    mealInstructions

                }
                .padding()
            }
        }
        .toolbarBackground(backgroundColor, for: .navigationBar)
    }
    
    /// Function to fetch the instructions and ingredients using idMeal & MealService
    private func fetchDetailedMealData() {
        MealService().fetchDetailedMeal(idMeal: meal.idMeal) { fetchedMeal in
            if let fetchedMeal = fetchedMeal {
                DispatchQueue.main.async {
                    self.instructions = fetchedMeal.strInstructions ?? ""
                    self.ingredients = fetchedMeal.ingredients
                }
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: .mealTest)
    }
}



// MARK: View extensions
extension MealDetailView {
    
    /// mealDetailImageView handles the photo of the dessert (strMealThumb) as well as the view's background color
    @ViewBuilder
    var mealDetailImageView: some View {
        if let url = URL(string: meal.strMealThumb) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.4), radius: 10, x: -8, y: 5)
                        .overlay {
                            LinearGradient(colors: [.clear, .black.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                                .cornerRadius(12)
                        }

                        .overlay(alignment: .bottomLeading) {
                            Text(meal.strMeal)
                                .multilineTextAlignment(.leading)
                                .font(.title).bold()
                                .foregroundColor(.white)
                                .frame(width: 200)
                                .padding(.bottom, 20)
                        }
                        .onAppear {
                            // Extract the dominant color from the image
                           extractDominantColor(from: meal.strMealThumb) { color in
                               self.backgroundColor = color.opacity(0.5)
                            }
                        }
                } placeholder: {
                    ProgressView()
                        .frame(maxHeight: 200)
                }
        } else {
            // Return a placeholder view in case the URL is nil or image loading fails
                Color.gray
                    .frame(maxHeight: 200)
        }


    }
    
    /// ingredientsList handles the list of the ingredients and their measures for the given dessert
    @ViewBuilder
    var ingredientsList: some View {
           if !ingredients.isEmpty {
                   DisclosureGroup(
                       isExpanded: $isIngredientsExpanded,
                       content: {
                           ForEach(ingredients, id: \.self) { ingredient in
                               HStack {
                                   Text("\(ingredient.name):")
                                       .bold()
                                   Text(ingredient.measure)
                                       .opacity(0.5)
                               }
                           }
                       },
                       label: {
                           Text("Ingredients:")
                               .font(.title2)
                               .bold()
                       }
                   )
           } else {
               // Show user error message if ingredients do not load/do not exist
               Text("ERROR: Failed to load meal ingredients")
           }
       }
    
    /// mealInstructions handles the instructions for preparing the dessert.
    @ViewBuilder
    var mealInstructions: some View {
        if !instructions.isEmpty{
                DisclosureGroup(
                    isExpanded: $isInstructionsExpanded,
                    content: {
                        Text(instructions)
                    },
                    label: {
                        Text("Instructions:")
                            .font(.title2)
                            .bold()
                    }
                )
                .padding(.bottom, 16)
                .onAppear {
                    fetchDetailedMealData()
                }
            
        } else {
            // Show user error message if instructions do not load/do not exist
            Text("ERROR: Failed to load meal instructions")
                .scenePadding()
        }
    }

}

