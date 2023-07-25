//
//  AfterburnerApp.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import SwiftUI

@main
struct AfterburnerApp: App {
    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .fixedSize()
//        }.windowResizability(.contentSize)
        WindowGroup {
            OnboardingView(pages: OnboardingPage.allCases)
        }.windowStyle(.hiddenTitleBar)
    }
}

