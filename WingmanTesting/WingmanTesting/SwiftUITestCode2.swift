/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
//
//  SwiftUITestCode2.swift
//  WingmanTesting
//
//  Created by Aditya Saravana on 3/3/23.
//

import SwiftUI

struct SwiftUITestCode2: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            // Add a TextEditor and store the text in a State variable named text.
        }
    }
}

struct SwiftUITestCode2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITestCode2()
    }
    
}

struct TextEditor: UIViewRepresentable {
    @Binding var text: String
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = text
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
