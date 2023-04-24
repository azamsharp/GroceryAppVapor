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
    
    @EnvironmentObject private var model: GroceryModel
    
    private func login() async {
        do {
            let loginResponse = try await model.login(username: username, password: password)
            if !loginResponse.error {
                // take user to the grocery category list screen
                
            } else {
                // show error
            }
        } catch {
            
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
