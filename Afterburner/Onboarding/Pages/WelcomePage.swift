//
//  Welcome.swift
//  Afterburner
//
//  Created by Aditya Saravana on 7/24/23.
//

import SwiftUI

struct WelcomePage: View {
    @Binding var disableNextButton: Bool
    let page = OnboardingPage.welcome
    var body: some View {
        VStack {
            Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                .resizable()
                .frame(width: 128, height: 128)
                .padding()
            
            Text("Welcome to Afterburner")
                .bold()
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("You're only a few seconds away from coding at supersonic speed. Let's get you started.").font(.title2)
            
        }
        .modifier(OnboardingViewPage())
        .onAppear { disableNextButton = false }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage(disableNextButton: .constant(false))
    }
}


