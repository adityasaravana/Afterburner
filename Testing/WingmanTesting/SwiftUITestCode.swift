//
//  SwiftUITestCode.swift
//  WingmanTesting
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI

// Test code
// Create a textfield and store the text in an @State variable
struct ContentView: View {
    @State var text: String = ""
    var body: some View {
        VStack {
            Text("Hello, World!")
            TextField("Enter text", text: $text)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
