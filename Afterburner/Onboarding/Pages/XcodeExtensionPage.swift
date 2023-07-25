//
//  XcodeExtensionPage.swift
//  Afterburner
//
//  Created by Aditya Saravana on 7/24/23.
//

import SwiftUI

struct XcodeExtensionPage: View {
    @Binding var disableNextButton: Bool
    
    var body: some View {
        VStack {
            Image("Xcode")
                .resizable()
                .frame(width: 128, height: 128)
                .padding()
            Text("Enable Xcode Access")
                .bold()
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("You'll need to enable the source editor extension to use Afterburner in Xcode. Click the button below to launch Settings. Once you're there, click Xcode Source Editor, then enable Afterburner.")
                .multilineTextAlignment(.center)
                .font(.title2)
            Button {
                disableNextButton = false
                NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Extensions.prefPane"))
            } label: {
                Text("Open Settings")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                    .background(Color.blue.cornerRadius(25))
            }
            .buttonStyle(.borderless)
            .padding()
        }
        .modifier(OnboardingViewPage())
        .onAppear {
            disableNextButton = true
        }
    }
}

struct XcodeExtensionPage_Previews: PreviewProvider {
    static var previews: some View {
        XcodeExtensionPage(disableNextButton: .constant(false))
    }
}
