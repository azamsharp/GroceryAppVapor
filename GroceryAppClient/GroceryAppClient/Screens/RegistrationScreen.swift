//
//  RegistrationScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10)
    }
    
    private func register() async {
        
        do {
            let registered = try await model.register(username: username, password: password)
            if registered {
                appState.routes.append(.login)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Text("Must be between 6 and 10 characters")
                .font(.caption)
            
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                }.disabled(!isFormValid)
                Spacer()
                Button("Login") {
                    appState.routes.append(.login)
                }.buttonStyle(.borderless)
                
            }
            
            if let errorMessage {
                Text(errorMessage)
            }
            
            
        }.navigationTitle("Registration")
    }
}

struct RegistrationScreenContainerView: View {
    
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            RegistrationScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .register:
                            RegistrationScreen() 
                        case .login:
                            Text("Login")
                        case .groceryCategoryList:
                            Text("Grocery Category List")
                        case .groceryCategoryDetail(let groceryCategory):
                            Text(groceryCategory.title)
                    }
                }
        }
        .environmentObject(model)
        .environmentObject(appState)
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreenContainerView()
    }
}
