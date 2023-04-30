//
//  GroceryCategoryDetail.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/29/23.
//

import SwiftUI

struct GroceryCategoryDetail: View {
    
    let groceryCategory: GroceryCategory
    
    var body: some View {
        Text(groceryCategory.title)
    }
}

struct GroceryCategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        GroceryCategoryDetail(groceryCategory: GroceryCategory(id: UUID(), title: "Seafood", color: "#2ecc71", userId: UUID()))
    }
}
