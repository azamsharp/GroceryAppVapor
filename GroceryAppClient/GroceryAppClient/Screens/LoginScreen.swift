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
            print(isLoggedIn)
            if isLoggedIn {
                // take user to the grocery category list screen
                appState.routes.append(.groceryCategoryList)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            HStack {
                
                Button("Login") {
                    Task {
                        await login()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
                
                Spacer()
                
                Button("Register") {
                    appState.routes.append(.register)
                }.buttonStyle(.borderless)
            }
            
           
            
            if let errorMessage {
                Text(errorMessage)
            }
            
        }.navigationTitle("Login")
            .navigationBarBackButtonHidden(true) 
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
