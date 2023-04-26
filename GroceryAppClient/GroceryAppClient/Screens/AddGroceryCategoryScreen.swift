//
//  AddGroceryCategoryScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/26/23.
//

import SwiftUI

struct AddGroceryCategoryScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    
    private func saveGroceryCategory() async {
        
        let groceryCategory = GroceryCategory(title: title, color: "#000080", userId: UUID(uuidString: "47524ecc-4ff3-466d-9f6e-753d89a8433f")!)
        do {
            try await model.saveGroceryCategory(groceryCategory: groceryCategory)
        } catch {
            model.lastError = error
        }
    }
    
    // make sure it is valid
    // private var isFormValid
    
    var body: some View {
        Form {
           
            TextField("Title", text: $title)
            
            if let error = model.lastError {
                Text(error.localizedDescription)
            }
           
            
        }.navigationTitle("New Category")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await saveGroceryCategory()
                        }
                    }
                }
            }
    }
}

struct AddGroceryCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryCategoryScreen()
                .environmentObject(GroceryModel())
        }
    }
}
