//
//  ContentView.swift
//  Wingman
//
//  Created by Aditya Saravana on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    @State var user = WingmanUser.sharedInstance
    var body: some View {
        VStack {
            Text("Wingman").bold()
            TextField("Enter License Key", text: $user.licenseKey)
            Divider().foregroundColor(.gray)
            
            
            HUD(user: $user)
            Divider()
            Text("Docs").bold().font(.title2)
            
            HStack {
                NavigationLink(destination: InstallationInstructionView(), label: {
                    VStack {
                        Image(systemName: "arrow.down.app.fill")
                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    }
                })
            }
            
            
            Spacer()
        }
        .padding(.all)
        .frame(width: 300, height: 500, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HUD: View {
    @Binding var user: WingmanUser
    var body: some View {
        VStack {
            Text("HUD")
                .bold()
                .font(.title2)
            HStack {
                Text("Current Wingman Status:")
                switch user.status {
                case .notRunning:
                    Text("Not running").foregroundColor(.gray)
                case .awaitingResponse:
                    Text("Running, awaiting response from OpenAI").foregroundColor(.yellow)
                case .error:
                    Text("Error, failed to fetch status").foregroundColor(.red)
                }
            }
            
            if user.licenseLeyValid {
                HStack {
                    Text("License Status:")
                    Text("Activated").foregroundColor(.green)
                }
            } else {
                HStack {
                    Text("License Status:")
                    Text("No License Added").foregroundColor(.red)
                }
                Text("Free Uses Left: 9").font(.caption)
            }
            
//            Spacer()
        }
        
        
        .padding()
    }
}
