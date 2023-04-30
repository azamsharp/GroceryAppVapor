//
//  GroceryCategoryDetail.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/29/23.
//

import SwiftUI

struct GroceryDetailScreen: View {
    
    @State private var isPresented: Bool = false
    let groceryCategory: GroceryCategory
    
    var body: some View {
        Text(groceryCategory.title)
            .navigationTitle(groceryCategory.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Grocery Item") {
                        isPresented = true
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddGroceryItemScreen()
                }
            }
    }
}

struct GroceryCategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryDetailScreen(groceryCategory: GroceryCategory(id: UUID(), title: "Seafood", color: "#2ecc71", userId: UUID()))
        }
    }
}
