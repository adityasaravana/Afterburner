/// Looks like you haven't entered your OpenAI API License Key yet.
/// Please follow the guide in the Wingman app to add your API key.
//
//  ContentView.swift
//  WingmanTesting
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            // Add a TextEditor here, and store the text in a state variable named text
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
