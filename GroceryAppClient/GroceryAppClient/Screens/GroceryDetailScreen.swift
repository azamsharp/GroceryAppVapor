//
//  GroceryCategoryDetail.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/29/23.
//

import SwiftUI
import GroceryAppShared

struct GroceryDetailScreen: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    let groceryCategory: GroceryCategoryResponseDTO
    
    private func deleteGroceryItem(groceryItemId: UUID) {
        Task {
            do {
                try await model.deleteGroceryItem(groceryCategoryId: groceryCategory.id, groceryItemId: groceryItemId)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        ZStack {
            if model.groceryItems.isEmpty {
                Text("No items found.")
            } else {
                GroceryItemListView(groceryItems: model.groceryItems, onDelete: deleteGroceryItem)
            }
        }.navigationTitle(groceryCategory.title)
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
            .task {
                await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
            }
            .onAppear {
                model.groceryCategory = groceryCategory
            }
    }
}

/*
struct GroceryCategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryDetailScreen(groceryCategory: GroceryCategory(id: UUID(), title: "Seafood", color: "#2ecc71", userId: UUID()))
                .environmentObject(GroceryModel())
        }
    }
} */
