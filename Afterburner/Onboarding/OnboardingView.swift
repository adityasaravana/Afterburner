//
//  OnboardingView.swift
//  Afterburner
//
//  Created by Aditya Saravana on 7/24/23.
//

import SwiftUI
import Defaults

struct OnboardingView: View {
    @State private var currentPage: OnboardingPage = .welcome
    @State var disableNextButton = false
    private let pages: [OnboardingPage]
    
    init(pages: [OnboardingPage]) {
        self.pages = pages
    }
    
    @ViewBuilder
    func view(_ page: OnboardingPage, action: @escaping () -> Void) -> some View {
        switch page {
        case .welcome:
            WelcomePage(disableNextButton: $disableNextButton)
        case .openAIKey:
            OpenAIKeyPage(disableNextButton: $disableNextButton)
        case .keyboardShortcuts:
            KeyboardShortcutsPage()
        case .xcodeExtension:
            XcodeExtensionPage(disableNextButton: $disableNextButton)
        }
    }
    
    var body: some View {
        ZStack {
            VisualEffectView()
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            
            ForEach(pages, id: \.self) { page in
                if page == currentPage {
                    view(page, action: showNextPage)
                        .modifier(OnboardingViewPage())
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    if currentPage != .welcome {
                        Button(action: showPreviousPage, label: {
                            Text("Back")
                                .bold()
                                .padding(.horizontal, 30)
                                .padding(.vertical, 5)
                                .background(.ultraThinMaterial)
                                .cornerRadius(25)
                        })
                        .buttonStyle(.borderless)
                        .padding()
                    }
                    Spacer()
                    Button {
                        switch currentPage.buttonType {
                        case .Next:
                            showNextPage()
                        case .Skip:
                            showNextPage()
                        case .Done:
                            Defaults[.onboard] = false
                            withAnimation {
                                NSApp.windows.first?.close()
                            }
                        }
                    } label: {
                        var color: Color {
                            if disableNextButton {
                                return .gray
                            } else {
                                return .accentColor
                            }
                        }
                        
                        var text: String {
                            switch currentPage.buttonType {
                            case .Next:
                                return "Next"
                            case .Skip:
                                return "Skip/Next"
                            case .Done:
                                return "Done"
                            }
                        }
                        
                        Text(text)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.horizontal, 30)
                            .padding(.vertical, 5)
                            .background(color.cornerRadius(25))
                    }
                    .disabled(disableNextButton)
                    .keyboardShortcut(.defaultAction)
                    .buttonStyle(.borderless)
                    .padding()
                }
            }
        }
        .onAppear { self.currentPage = pages.first! }
        
    }
    
    private func showNextPage() {
        guard let currentIndex = pages.firstIndex(of: currentPage), pages.count > currentIndex + 1 else {
            return
        }
        currentPage = pages[currentIndex + 1]
    }
    
    private func showPreviousPage() {
        guard let currentIndex = pages.firstIndex(of: currentPage) else {
            return
        }
        currentPage = pages[currentIndex - 1]
    }
}

struct preview: PreviewProvider {
    static var previews: some View {
        OnboardingView(pages: OnboardingPage.allCases)
    }
}

