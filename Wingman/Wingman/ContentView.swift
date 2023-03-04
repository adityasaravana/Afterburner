//
//  ContentView.swift
//  Wingman
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @State var sheetShowing = false
    var body: some View {
        ZStack {
            Image("fighterjet").opacity(0.7)
            VStack {
                Text("Thanks for Downloading.").bold().font(.title)
                Text("Editor -> Wingman For Xcode -> Radio Wingman")
                Link("Add Your OpenAI API Key", destination: URL(string: "https://thedevdude.notion.site/Adding-Your-OpenAI-API-Key-8e1149e6bc754781bd207d6a0142c378")!)
                Text("Help is available at aditya.saravana@icloud.com.")
                
            }
            .padding()
            .background(
                .thinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

