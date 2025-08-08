//
//  SearchBarView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 07.08.2025.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @FocusState private var searchBarIsFocused: Bool
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondary : Color.theme.accent
                )
            TextField("Поиск по имени или символу...", text: $searchText)
                .focused($searchBarIsFocused)
                .foregroundStyle(Color.theme.accent)
                .tint(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            searchText = ""
                                searchBarIsFocused = false
                        }
                    ,alignment: .trailing
                )
                .autocorrectionDisabled()
            
                
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.2),
                    radius: 10)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
