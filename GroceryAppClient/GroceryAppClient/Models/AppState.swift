//
//  AppState.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/24/23.
//

import Foundation

enum Route: Hashable {
    case groceryCategoryList
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
