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
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                LoginScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .login:
                                LoginScreen() 
                            case .groceryCategoryList:
                                GroceryCategoryListScreen()
                        }
                    }
            }
            .environmentObject(model)
            .environmentObject(appState)
            
        }
    }
}
