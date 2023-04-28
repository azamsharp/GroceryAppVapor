//
//  ContentView.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    
    let colorCode = "#000080"
    
    var body: some View {
        VStack {
           Circle()
                .fill(Color.fromHex(colorCode))
                .frame(width: 25, height: 25)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
