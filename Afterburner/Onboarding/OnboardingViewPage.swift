//
//  OnboardingViewPage.swift
//  Afterburner
//
//  Created by Aditya Saravana on 7/24/23.
//

import SwiftUI

struct OnboardingViewPage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 800, height: 600)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
            .transition(AnyTransition.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading))
            )
            .animation(.default)
        
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .underWindowBackground

        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}
