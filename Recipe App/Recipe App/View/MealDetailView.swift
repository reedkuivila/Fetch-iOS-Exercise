//
//  MealDetailView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//
//

import SwiftUI

struct MealDetailView: View {
    // test instructions
    @State private var instructions: String = "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm."
    //    @State private var instructions: String = "Loading instructions..."
    @State private var isInstructionsExpanded = false
    @State private var isIngredientsExpanded = true // Set to true to initially expand ingredients
    @State private var ingredients: [Ingredient] = []
    let meal: Meal
    
    @State private var backgroundColor: Color = .white // Initial background color
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Dessert image
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
                                                        backgroundColor = extractDominantColor(from: image)
                                                    }
                        } placeholder: {
                            ProgressView()
                                .frame(maxHeight: 200)
                        }
                       
                
                    }
                    
                    // Dessert ingredients
                    if !ingredients.isEmpty {
                        DisclosureGroup(
                            isExpanded: $isIngredientsExpanded, // Use this state variable to control expansion
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
                    }
                    // For testing purposes - remove before submission
                    else {
                        DisclosureGroup(
                            isExpanded: $isIngredientsExpanded, // Use this state variable to control expansion
                            content: {
                                ForEach(meal.ingredients, id: \.self) { ingredient in
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
                                .bold()                        }
                        )
                    }
                    
                    // Dessert baking instructions
                    if !instructions.isEmpty {
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
                    }
                }
                .padding()
            }
        }
    }
    
    //     function to fetch the instructions and ingredients
    private func fetchDetailedMealData() {
        // Fetch detailed meal data using the meal's idMeal
        MealService().fetchDetailedMeal(idMeal: meal.idMeal) { fetchedMeal in
            if let fetchedMeal = fetchedMeal {
                DispatchQueue.main.async {
                    self.instructions = fetchedMeal.strInstructions ?? ""
                    self.ingredients = fetchedMeal.ingredients
                }
            }
        }
    }
    
    private func extractDominantColor(from image: Image) -> Color {
        // Implement your color extraction logic here
        // You can use libraries like Core Image or third-party libraries to extract colors
        // For simplicity, I'm using a static color here
        return Color.blue
    }
    
}


struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: .mealTest)
    }
}


