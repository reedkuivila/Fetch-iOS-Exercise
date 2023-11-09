//
//  MainHeaderView.swift
//  Recipe App
//
//  Created by reed kuivila on 11/8/23.
//

import SwiftUI

/// A custom header view for the MainView
struct MainHeaderView: View {
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Find the perfect dessert")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)

            Text("or search for your craving below")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.leading)

            SearchTextField(text: $text)
        }
    }
}

/// A custom search bar
struct SearchTextField: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Try \"cake\"", text: $text)
                .autocorrectionDisabled(true)
                .padding(8)
                .padding(.leading, 24)
                .background(Color(.gray).opacity(0.1))
                .cornerRadius(7)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 7)
                    }
                )
        }
        .padding(.leading)
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
