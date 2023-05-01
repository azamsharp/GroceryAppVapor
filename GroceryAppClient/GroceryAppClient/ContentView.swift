//
//  ContentView.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    @State private var words: [String] = []
    
    
    var body: some View {
        VStack {
            Form {
                TextField("Enter word", text: $text)
            }.onSubmit {
                words.append(text)
                text = ""
            }
            List(words, id: \.self) { word in
                Text(word)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
