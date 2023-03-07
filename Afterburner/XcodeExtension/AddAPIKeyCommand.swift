//
//  AddAPIKeyCommand.swift
//  XcodeExtension
//
//  Created by Aditya Saravana on 3/2/23.
//

//import Foundation
//import XcodeKit
//
//class AddAPIKeyCommand: NSObject, XCSourceEditorCommand {
//    
//    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
//        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
//        
//        let user = User.sharedInstance
//        
//        let lines = invocation.buffer.lines
//        let linesString = lines.componentsJoined(by: "")
//        
//        user.apiKey = linesString.filter { !$0.isWhitespace }
//        
//        print("API KEY UPDATED: NEW API KEY IS \(user.apiKey)")
//        
//        completionHandler(nil)
//    }
//    
//}
