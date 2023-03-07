//
//  SourceEditorCommand.swift
//  XcodeExtension
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation
import XcodeKit
import AppKit

class BurnSWIFT: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        let user = User.sharedInstance
        
        let lines = invocation.buffer.lines
        let orignialLines = lines
        let linesString = lines.componentsJoined(by: "")
        
        if user.data.apiKey != "" {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(linesString, forType: .string)
            
            let response = OpenAIConnector().burn_swift(linesString)
            
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
        
        completionHandler(nil)
    }
    
}
