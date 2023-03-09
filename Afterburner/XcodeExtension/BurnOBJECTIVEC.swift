//
//  Burn_OBJECTIVEC.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/6/23.
//

import Foundation
import XcodeKit
import AppKit

class BurnOBJECTIVEC: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        Burner().burn(language: .objective_c, code: invocation.buffer.lines)
        
        completionHandler(nil)
    }
    
}
