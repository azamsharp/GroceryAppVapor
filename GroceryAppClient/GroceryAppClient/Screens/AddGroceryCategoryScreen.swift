//
//  AddGroceryCategoryScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/26/23.
//

import SwiftUI

struct AddGroceryCategoryScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
        }.navigationTitle("New Category")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        
                    }
                }
            }
    }
}

struct AddGroceryCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryCategoryScreen()
        }
    }
}
