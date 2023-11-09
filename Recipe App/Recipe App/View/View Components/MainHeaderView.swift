//
//  MainHeaderView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/8/23.
//

import SwiftUI

struct MainHeaderView: View {
    @State private var randomImageURL: URL?
    
    var body: some View {
        AsyncImage(
            url: randomImageURL,
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
            },
            placeholder: {
                ProgressView()
            }
        )
        .onAppear {
            // Fetch a random meal image URL and set it to randomImageURL
            fetchRandomMealImageURL()
        }
    }
    
    private func fetchRandomMealImageURL() {
        // Generate a random meal image URL or use a default URL
        // You should implement your logic here to get a random meal image URL
        // For example, you can fetch it from an API
        // Here, we use a default URL for demonstration purposes
        randomImageURL = URL(string: "https://www.themealdb.com/images/media/meals/randomImage.jpg")
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView()
    }
}

