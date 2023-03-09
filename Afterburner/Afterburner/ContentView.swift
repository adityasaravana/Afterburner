//
//  ContentView.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var sheetShowing = false
    @State var apiKeyLocal = ""
    @State var maxTokenCountLocal = 720
    
    var maxPossiblePrice: Double {
        return (Double(maxTokenCountLocal) / 1000) * 0.02
    }
    
    var body: some View {
        ZStack {
            Image("fighterjet").opacity(0.7)
            
            VStack {
                Text("Debug Text Loader \(DataManager().readValue("OPENAIKEY") ?? "NO API KEY")")
                Text("Thanks for Downloading.").bold().font(.title).padding([.leading, .bottom, .trailing])
                Text("Editor -> Afterburner For Xcode -> Activate Afterburner")
                
                Divider()
                Label("Settings", systemImage: "gear")
                TextField("Paste your OpenAI API Key Here", text: $apiKeyLocal)
                HStack {
                    Stepper("Maximum Possible API Charge: $\(maxPossiblePrice)", value: $maxTokenCountLocal, step: 20)
                    Text("(\(maxTokenCountLocal) tokens)").font(.caption2)
                    
                }
                
                Button("Update Settings") {
                    DataManager().writeValue(apiKeyLocal.filter { !$0.isWhitespace }, key: "OPENAIKEY")
                    DataManager().writeValue(String(maxTokenCountLocal), key: "MAXTOKENS")
                    
                    print("updated")
                }
                
                Divider()
                Text("Help is available at aditya.saravana@icloud.com.").font(.caption2)
                
            }
            .frame(width: 380)
            .padding()
            .background(
                .thinMaterial,
                in: RoundedRectangle(cornerRadius: 15, style: .continuous)
            )
            
        }.fixedSize()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

