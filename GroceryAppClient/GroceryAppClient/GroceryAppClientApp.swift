//
//  GroceryAppClientApp.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import SwiftUI

@main
struct GroceryAppClientApp: App {
    
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        
        let _ = print("GroceryAppClientApp")
        // get the token from the user defaults
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: Constants.Strings.authToken)
        
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                
                Group {
                    if token == nil {
                        LoginScreen()
                    } else {
                        GroceryCategoryListScreen()
                    }
                } .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .login:
                            LoginScreen()
                        case .groceryCategoryList:
                            GroceryCategoryListScreen()
                        case .groceryCategoryDetail(let groceryCategory):
                            GroceryCategoryDetail(groceryCategory: groceryCategory)
                    }
                }
                   
            }
            .environmentObject(model)
            .environmentObject(appState)
            
        }
    }
}
