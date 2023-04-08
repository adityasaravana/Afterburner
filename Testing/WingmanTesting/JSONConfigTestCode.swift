// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
//
// JSONConfigTestCode.swift
// XCExtensionTesting
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation

struct CodableStruct {
    var string: String
    var int: Int
}

public extension FileManager {
    static var documentsDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension CodableStruct: Codable {
    // add functions to this extension to encode and decode CodableStruct as a json file in FileManager.documentsDirectoryURL
}
