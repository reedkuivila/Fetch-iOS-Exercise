//
//  SearchBar.swift
//  Fetch iOS Assessment
//
//  Created by reed kuivila on 11/5/23.
//

import SwiftUI

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Find recipes here", text: $text)
                .autocorrectionDisabled(true)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.gray).opacity(0.1))
                .cornerRadius(20)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 7)
                    })
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
