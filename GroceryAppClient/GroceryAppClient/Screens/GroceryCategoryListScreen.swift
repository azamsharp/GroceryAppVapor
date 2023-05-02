//
//  GroceryListScreen.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/25/23.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    private func fetchGroceryCategories() async {
        await model.populateGroceryCategories()
    }
    
    private func deleteGroceryCategory(at offsets: IndexSet) {
        /*
        offsets.forEach { index in
            let groceryCategory = model.groceryCategories[index]
            
            Task {
                try await model.deleteGroceryCategory(groceryCategoryId: groceryCategory.id!)
            }
        } */
    }
    
    var body: some View {
        
        ZStack {
            if model.groceryCategories.isEmpty {
                Text("No grocery categories found.")
            } else {
                List {
                    ForEach(model.groceryCategories) { groceryCategory in
                        NavigationLink(value: Route.groceryCategoryDetail(groceryCategory)) {
                            HStack {
                                HStack {
                                    Circle()
                                        .fill(Color.fromHex(groceryCategory.color))
                                        .frame(width: 25, height: 25)
                                    Text(groceryCategory.title)
                                    Spacer()
                                    Text("33")
                                }
                            }
                        }
                        
                    }.onDelete(perform: deleteGroceryCategory)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Grocery Categories")
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Logout") {
                    model.logout()
                    // take the user to the login screen
                    appState.routes.append(.login)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // action
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AddGroceryCategoryScreen()
            }
        }
        .task {
            await fetchGroceryCategories()
        }
    }
}

struct GroceryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryCategoryListScreen()
                .environmentObject(GroceryModel())
                .environmentObject(AppState())
        }
    }
}
