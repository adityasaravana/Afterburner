//
//  OpenAIKeyPage.swift
//  Afterburner 
//
//  Created by Aditya Saravana on 7/25/23.
//

import SwiftUI

struct OpenAIKeyPage: View {
    @State var showResponseArea = false
    @State var loading = false
    @State var APIKeyLocal = ""
    @State var secureField = true
    @State var response = ""
    @Binding var disableNextButton: Bool
    let keychainManager = DataManager()
    
    var body: some View {
        VStack {
            Image(systemName: "brain")
                .font(.system(size: 128))
                .padding()
            Text("Add An OpenAI API Key")
                .bold()
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("Afterburner uses the OpenAI API to give you powerful AI-based code completion. To get started, you'll need an API key linked to a payment method so Afterburner can communicate with OpenAI. You can always change this later.")
                .multilineTextAlignment(.center)
                .font(.title2)
            
            HStack {
                Button {
                    secureField.toggle()
                } label: {
                    if secureField {
                        Image(systemName: "eye.slash")
                    } else {
                        Image(systemName: "eye")
                    }
                }
                
                if secureField {
                    SecureField("Paste OpenAI API Key Here", text: $APIKeyLocal)
                        .autocorrectionDisabled(true)
                        .textFieldStyle(.roundedBorder)
                } else {
                    TextField("Paste OpenAI API Key Here", text: $APIKeyLocal)
                        .autocorrectionDisabled(true)
                        .textFieldStyle(.roundedBorder)
                }
                
                Button("Save") {
                    response = ""
                    showResponseArea = true
                    loading = true
                    
                    let validator = OpenAIConnector()
                    validator.logMessage("You are validator, a system that lets users check if their OpenAI API key is valid before entering the app. Once you get this message, respond with a dad joke. DO NOT respond with ANYTHING but the dad joke, as it'll mess up the app's UI.", messageUserType: .user)
                    
                    keychainManager.push(key: DataManager.Keys.openAIKey, content: APIKeyLocal.filter { !" \n\t\r".contains($0) })
                    
                    APIKeyLocal = ""
                    
                    Task {
                       
                        validator.sendToAssistant()
                        response = validator.messageLog.last?["content"] ?? "Looks like nothing came back from OpenAI."
                        disableNextButton = false
                        loading = false
                    }
                }.disabled(loading)
            }.padding(.horizontal, 40)
            
            if showResponseArea {
                Text("Your AI-generated dad joke:").padding(.top, 30)
                if !loading {
                    Text("\(response)")
                        .multilineTextAlignment(.center)
                        .bold()
                        .font(.title3)
                } else {
                    ProgressView().progressViewStyle(.circular)
                }
                
                Text("If the response looks good, click done. You're all set!").padding(.top, 30)
            }
            
            
            
        }
        .modifier(OnboardingViewPage())
        .onAppear {
            disableNextButton = true
        }
        
    }
}

struct OpenAIKeyPage_Previews: PreviewProvider {
    static var previews: some View {
        OpenAIKeyPage(showResponseArea: true, response: "response here", disableNextButton: .constant(true))
    }
}
