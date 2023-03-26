//
//  Burn.swift
//  Afterburner For Xcode
//
//  Created by Aditya Saravana on 3/8/23.
//

import Foundation
import XcodeKit
import AppKit

public struct Burner {
    func burn(language: AfterburnerLanguage, code: NSMutableArray) {
        let connector = OpenAIConnector()
        print("---------------")
        print(connector.openAIKey)
        
        let lines = code
        
        
        let orignialLines = lines
        let linesString = lines.componentsJoined(by: "")
        
        if connector.openAIKey != "" {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(linesString, forType: .string)
            
            var response: String? = ""
            
            switch language {
            case .swift:
                response = connector.burn_swift(linesString)
            case .objective_c:
                response = connector.burn_swift(linesString)
            }
            
            var editedLines = [
        """
        ///
        """
            ] + lines
            
            if response == nil {
//                completionHandler(NSError())
                editedLines = [
            """
            // Looks like your OpenAI API License key is invalid.
            """
                ] + lines
            } else {
                editedLines = [
            """
            // ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
            """
                ] + orignialLines + response!.split(whereSeparator: \.isNewline)
            }
            
            
            
            lines.removeAllObjects()
            lines.addObjects(from: editedLines)
        } else {
            
            let editedLines = [
        """
        // Looks like you haven't entered your OpenAI API License Key yet.
        // You can enter it in the Afterburner app.
        """
            ] + lines
            
            lines.removeAllObjects()
            lines.addObjects(from: editedLines)
            
        }
    }
}
