//
//  HomeView.swift
//  Fetch iOS Assessment
//
//  Created by reed kuivila on 11/5/23.
//

import SwiftUI

struct HomeView: View {
    @State var search: String = ""

    var body: some View {
        NavigationStack{
            ScrollView{
                // Header/title
                Text("What are you craving today?")
                    .font(.title)
                    .bold()

                // Searchbar view
                SearchBar(text: $search)

                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack {
                        MealTile(meal: .categoryDescriptionTest)
                        }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

