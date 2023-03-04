//
//  SourceEditorCommand.swift
//  XcodeExtension
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation
import XcodeKit
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        let user = User.sharedInstance
        
        let lines = invocation.buffer.lines
        let orignialLines = lines
        let linesString = lines.componentsJoined(by: "")
        
        if user.apiKey != "" {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(linesString, forType: .string)
            
            let response = OpenAIConnector().processDavinci(linesString)
            
            var editedLines = [
        """
        ///
        """
            ] + lines
            
            if response == nil {
//                completionHandler(NSError())
                editedLines = [
            """
            /// Looks like your OpenAI API License key is invalid.
            """
                ] + lines
            } else {
                editedLines = [
            """
            /// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
            """
                ] + orignialLines + response!.split(whereSeparator: \.isNewline)
            }
            
            
            
            lines.removeAllObjects()
            lines.addObjects(from: editedLines)
        } else {
            
            let editedLines = [
        """
        /// Looks like you haven't entered your OpenAI API License Key yet.
        /// Please follow the guide at
        /// https://thedevdude.notion.site/Adding-Your-OpenAI-API-Key-8e1149e6bc754781bd207d6a0142c378
        /// to add your API key.
        """
            ] + lines
            
            lines.removeAllObjects()
            lines.addObjects(from: editedLines)
            
        }
        
        completionHandler(nil)
    }
    
}
