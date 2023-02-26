//
//  SourceEditorCommand.swift
//  Wingman for Xcode
//
//  Created by Aditya Saravana on 2/1/23.
//

import Foundation
import XcodeKit
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        let user = WingmanUser.sharedInstance
        
        let lines = invocation.buffer.lines
        let linesString = lines.componentsJoined(by: "")
        
        if user.licenseLeyValid {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(linesString, forType: .string)
            
            let response = OpenAIConnector().processDavinci(linesString)
            if response == nil {
                completionHandler(NSError())
            }
            let editedLines = [
        """
        /// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
        """
            ] + response!.split(whereSeparator: \.isNewline)
            
            lines.removeAllObjects()
            
            lines.addObjects(from: editedLines)
            
            
        } else {
            let editedLines = [
        """
        /// It looks like you haven't entered a license key yet.
        /// To add your license key, follow the guide here:
        /// You can purchase a license key here: https://thedevdudedownloads.gumroad.com/l/wingman
        
        /// If this isn't your first time seeing this message, your license key is invalid.
        """
            ] + lines
            
            lines.removeAllObjects()
            lines.addObjects(from: editedLines)
        }
        
        completionHandler(nil)
    }
    
}
