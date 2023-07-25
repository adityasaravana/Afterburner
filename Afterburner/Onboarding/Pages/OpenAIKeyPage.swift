//
//  OpenAIKeyPage.swift
//  Afterburner 
//
//  Created by Aditya Saravana on 7/25/23.
//

import SwiftUI

struct OpenAIKeyPage: View {
    
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
                    
                    APIKeyLocal = ""
                    response = "Loading..."
                    Task {
                        let validator = OpenAIValidator(openAIKey: APIKeyLocal)
                        response = validator.validate(onboarding: true)
                        keychainManager.push(key: .openAIKey, content: APIKeyLocal.filter { !" \n\t\r".contains($0) })
                        disableNextButton = false
                    }
                }
            }.padding(.horizontal, 40)
            Text("OpenAI Response: \(response)")
                .bold()
                .font(.title3)
                .padding(.top, 30)
            Text("If the response looks good, click next.")
        }
        .modifier(OnboardingViewPage())
        .onAppear {
            disableNextButton = true
        }
        
    }
}

struct OpenAIKeyPage_Previews: PreviewProvider {
    static var previews: some View {
        OpenAIKeyPage(disableNextButton: .constant(true))
    }
}
