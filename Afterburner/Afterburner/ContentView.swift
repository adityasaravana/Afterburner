//
//  ContentView.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    let defaults = UserDefaults(suiteName: "afterburner.settings")
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
                Text("Debug Text Loader -- APIKEY:\(defaults?.string(forKey: "APIKEY") ?? "no bueno api key") MAXTOKENS:\(defaults?.string(forKey: "MAXTOKENS") ?? "No bueno max tokens")")
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
                    defaults?.set(apiKeyLocal.filter { !" \n\t\r".contains($0) }, forKey: "APIKEY")
                    defaults?.set(maxTokenCountLocal, forKey: "MAXTOKENS")
                    
                    print("updated")
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
            
        }
        .fixedSize()
        .frame(width: 500, height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

