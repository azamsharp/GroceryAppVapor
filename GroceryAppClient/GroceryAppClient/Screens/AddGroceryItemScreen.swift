//
//  AddGroceryItemScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/30/23.
//

import SwiftUI

struct AddGroceryItemScreen: View {
    
    @State private var title: String = ""
    @State private var price: Double? = nil
    @State private var quantity: Int? = nil
    
    @EnvironmentObject private var model: GroceryModel
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        
        guard let price = price,
              let quantity = quantity else {
            return false
        }
        
        return !title.isEmptyOrWhiteSpace && price > 0 && quantity > 0
    }
    
    private func saveGroceryItem() async {
        
        guard let groceryCategory = model.groceryCategory,
              let groceryCategoryId = groceryCategory.id
        else { return }
        
        let groceryItem = GroceryItem(title: title, price: price!, quantity: quantity!)
        do {
            try await model.saveGroceryItem(groceryItem: groceryItem, groceryCategoryId: groceryCategoryId)
            dismiss()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Price", value: $price, format:.currency(code: Locale.current.currencySymbol ?? ""))
            TextField("Quantity", value: $quantity, format:.currency(code: Locale.current.currencySymbol ?? ""))
        }
        .navigationTitle("Add Grocery Item")
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    Task {
                        if isFormValid {
                            await saveGroceryItem()
                        }
                    }
                }.disabled(!isFormValid)
            }
        }
    }
}

struct AddGroceryItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryItemScreen()
                .environmentObject(GroceryModel())
        }
    }
}
