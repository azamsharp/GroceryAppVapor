//
//  GroceryListScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/25/23.
//

import SwiftUI

struct GroceryListScreen: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Text("GroceryListScreen")
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
                AddGroceryCategoryScreen() 
            }
    }
}

struct GroceryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryListScreen()
        }
    }
}
