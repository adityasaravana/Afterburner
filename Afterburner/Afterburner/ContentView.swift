//
//  ContentView.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    let dataManager = DataManager()
    
    var openAIKeyDisplayer: String {
        if dataManager.pull(key: .Afterburner_UserOpenAIKey) == "" || dataManager.pull(key: .Afterburner_UserOpenAIKey) == nil {
            return "Not Added"
        } else {
            return dataManager.pull(key: .Afterburner_UserOpenAIKey)!
        }
    }
    
    @State var sheetShowing = false
    @State var apiKeyLocal = ""
    @State var maxTokenCountLocal = 720
    @State private var updater = UUID()
    
    func update() { updater = UUID() }
    
    var maxPossiblePrice: Double {
        return (Double(maxTokenCountLocal) / 1000) * 0.002
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
                    Stepper("Maximum Possible API Charge: $\(maxPossiblePrice)", value: $maxTokenCountLocal, step: 20)
                    Text("(\(maxTokenCountLocal) tokens)").font(.caption2)
                    
                }
                
                Button("Update Settings") {
                    dataManager.push(key: .Afterburner_UserOpenAIKey, content: apiKeyLocal.filter { !" \n\t\r".contains($0) })
                    dataManager.push(key: .Afterburner_MaxTokensAllowedByUser, content: String(maxTokenCountLocal))
                    
                    update()
                    print(updater)
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

