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
    @State private var colorCode: String = ""
    
    
    private func saveGroceryCategory() async {
        
        let groceryCategoryRequest = GroceryCategoryRequest(title: title, color: colorCode)
        
        do {
            try await model.saveGroceryCategory(groceryCategoryRequest: groceryCategoryRequest)
            dismiss()
        } catch {
            model.lastError = error
        }
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
           
            TextField("Title", text: $title)
            ColorSelectionView(colorCode: $colorCode)
            
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
                    }.disabled(!isFormValid)
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
