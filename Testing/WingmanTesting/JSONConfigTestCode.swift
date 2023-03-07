// Looks like you haven't entered your OpenAI API License Key yet.
// Please follow the guide at
// https://thedevdude.notion.site/Adding-Your-OpenAI-API-Key-8e1149e6bc754781bd207d6a0142c378
// to add your API key.

//
//  JSONConfigTestCode.swift
//  WingmanTesting
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
    // add functions to this extension to encode and decode CodableStruct as a json file to FileManager.documentsDirectoryURL
}
