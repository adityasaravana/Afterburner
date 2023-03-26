// Looks like your OpenAI API License key is invalid.
// Looks like your OpenAI API License key is invalid.
// Looks like your OpenAI API License key is invalid.

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
    // add functions to this extension to encode and decode CodableStruct as a json file to FileManager.documentsDirectoryURL
}
