//
//  ContentView.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI
import Defaults

struct ContentView: View {
    @Default(.maxTokens) var maxTokens
    let dataManager = DataManager()
    
    var openAIKeyDisplayer: String {
        if dataManager.pull(key: .openAIKey) == "" || dataManager.pull(key: .openAIKey) == nil {
            return "Not Added"
        } else {
            return dataManager.pull(key: .openAIKey)!
        }
    }
    
    @State var sheetShowing = false
    @State var apiKeyLocal = ""
    @State private var updater = UUID()
    
    func update() { updater = UUID() }
    
    var maxPossiblePrice: Double {
        return (Double(maxTokens) / 1000) * 0.002
    }
    
    var body: some View {
        ZStack {
            Image("fighterjet").opacity(0.7)
            
            VStack {
                
                Text("Thanks for Downloading.").bold().font(.title).padding([.leading, .bottom, .trailing])
                Text("Editor -> Afterburner For Xcode -> Activate Afterburner")
                
                Divider()
                Label("Settings", systemImage: "gear")
                TextField("Paste your OpenAI API Key Here", text: $apiKeyLocal)
//                Text("OpenAI API Key: \(openAIKeyDisplayer)").bold().font(.caption)
                HStack {
                    Stepper("Maximum Possible API Charge: $\(maxPossiblePrice)", value: $maxTokens, step: 100)
                    Text("(\(maxTokens) tokens)").font(.caption2)
                    
                }
                
                
                
                Divider()
                Text("Help is available at aditya.saravana@icloud.com.").font(.caption2)
                
            }
            .frame(width: 380)
            .padding()
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 15, style: .continuous)
            )
            
        }.frame(height: 500)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

