//
//  LoginScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/24/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var model: GroceryModel
    
    private func login() async {
        do {
            let isLoggedIn = try await model.login(username: username, password: password)
            if isLoggedIn {
                // take user to the grocery category list screen
                appState.routes.append(.groceryCategoryList)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button("Login") {
                Task {
                    await login()
                }
            }
            
            if let errorMessage {
                Text(errorMessage)
            }
            
        }.navigationTitle("Login")
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginScreen()
                .environmentObject(GroceryModel())
        }
    }
}
