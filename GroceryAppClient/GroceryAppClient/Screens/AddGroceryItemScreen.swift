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
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && price != nil && quantity != nil
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
                    
                }.disabled(!isFormValid)
            }
        }
    }
}

struct AddGroceryItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryItemScreen()
        }
    }
}
