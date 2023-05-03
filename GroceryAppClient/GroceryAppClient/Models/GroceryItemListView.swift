//
//  GroceryItemListView.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 5/1/23.
//

import SwiftUI

struct GroceryItemListView: View {
    
    let groceryItems: [GroceryItem]
    let onDelete: (UUID) -> Void
    
    private func deleteGroceryItem(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let groceryItem = groceryItems[index]
            Task {
                onDelete(groceryItem.id!)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(groceryItems) { groceryItem in
                Text(groceryItem.title)
            }.onDelete(perform: deleteGroceryItem)
        }
    }
}

struct GroceryItemListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemListView(groceryItems: [], onDelete: { _ in })
    }
}
