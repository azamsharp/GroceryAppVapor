//
//  GroceryItemListView.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 5/1/23.
//

import SwiftUI

struct GroceryItemListView: View {
    
    let groceryItems: [GroceryItem]
    
    var body: some View {
        List(groceryItems) { groceryItem in
            Text(groceryItem.title)
        }
    }
}

struct GroceryItemListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemListView(groceryItems: [])
    }
}
