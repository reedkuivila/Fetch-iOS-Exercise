//
//  MealRowView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/7/23.
//


import SwiftUI

struct MealRowView: View {
    var meal: Meal
    
    var body: some View {
        VStack(spacing: 12) {
            if let url = URL(string: meal.strMealThumb) {
                AsyncImage(url: url) { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 225)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.4), radius: 10, x: -8, y: 5)
                        .overlay {
                            LinearGradient(colors: [.clear, .black.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                                .cornerRadius(12)
                        }
                        .overlay(alignment: .bottomLeading) {
                            Text(meal.strMeal)
                                .multilineTextAlignment(.leading)
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 120)
                                .padding(.leading, 8)
                                .padding(.bottom, 20)
                        }
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 300)
                }
            } else {
                Image(systemName: "photo.artframe")
                    .imageScale(.large)
            }
        }
        .padding()
    }
}


struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        MealRowView(meal: .mealTest)
    }
}
