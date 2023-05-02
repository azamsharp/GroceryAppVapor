//
//  AppState.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/24/23.
//

import Foundation
import GroceryAppShared

enum Route: Hashable {
    case login
    case register 
    case groceryCategoryList
    case groceryCategoryDetail(GroceryCategoryResponseDTO)
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
