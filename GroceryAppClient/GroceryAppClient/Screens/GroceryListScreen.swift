//
//  GroceryListScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/25/23.
//

import SwiftUI

struct GroceryListScreen: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    private func fetchGroceryCategories() async {
        await model.populateGroceryCategories()
    }
    
    var body: some View {
        List(model.groceryCategories) { groceryCategory in
            HStack {
                HStack {
                    Circle()
                        .fill(Color.fromHex(groceryCategory.color))
                         .frame(width: 25, height: 25)
                    Text(groceryCategory.title)
                }
            }
        }
        .navigationTitle("Grocery Categories")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // action
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AddGroceryCategoryScreen()
            }
        }
        .task {
            await fetchGroceryCategories()
        }
    }
}

struct GroceryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryListScreen()
                .environmentObject(GroceryModel())
        }
    }
}
