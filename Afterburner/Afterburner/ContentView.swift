//
//  ContentView.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI
import PDFKit

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
                Text("Debug Text Loader \(UserDefaults(suiteName:"com.devdude.afterburner.userData")!.string(forKey: "OPENAIKEY")!)")
                Text("Thanks for Downloading.").bold().font(.title).padding([.leading, .bottom, .trailing])
                Text("Editor -> Afterburner For Xcode -> Activate Afterburner")
//                Link("Add Your OpenAI API Key", destination: URL(string: "https://thedevdude.notion.site/Adding-Your-OpenAI-API-Key-8e1149e6bc754781bd207d6a0142c378")!)
                
                Divider()
                Label("Settings", systemImage: "gear")
                TextField("Paste your OpenAI API Key Here", text: $apiKeyLocal)
                HStack {
                    Stepper("Maximum Possible API Charge: $\(maxPossiblePrice)", value: $maxTokenCountLocal, step: 20)
                    Text("(\(maxTokenCountLocal) tokens)").font(.caption2)
                    
                }
                
                Button("Update Settings") {
//                    UserDefaults(suiteName: "com.devdude.afterburner.userData")!.set(apiKeyLocal, forKey: "OPENAIKEY")
//                    UserDefaults(suiteName: "com.devdude.afterburner.userData")!.set(maxTokenCountLocal, forKey: "MAXTOKENS")
                    
                    DataManager().writeValue(apiKeyLocal, key: "OPENAIKEY")
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

